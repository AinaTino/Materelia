
# assigner-materiels


// supabase/functions/assigner-materiels/index.ts
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "jsr:@supabase/server@^1";

export default {
  fetch: withSupabase({ auth: "user" }, async (req, { supabase }) => {
    try {
      const { lignes, lieu_utilisation, date_fin_prevue } = await req.json();

      if (!lignes || lignes.length === 0) {
        return Response.json({ error: "Panier vide" }, { status: 400 });
      }

      const { data: { user }, error: authError } = await supabase.auth.getUser();
      if (authError || !user) {
        return Response.json({ error: "Non authentifié" }, { status: 401 });
      }

      const ticketsCrees: string[] = [];
      const lignesRetirees: string[] = [];
      const materielsAssignes: { materiel: any; zone_id: string }[] = [];

      for (const ligne of lignes) {
        const { categorie_id, nombre } = ligne;

        for (let i = 0; i < nombre; i++) {
          const { data: materiel } = await supabase
            .from("materiels")
            .select("id_materiel, nom, id_stock, stocks(id_zone)")
            .eq("id_categorie", categorie_id)
            .eq("etat", "EN_STOCK")
            .limit(1)
            .maybeSingle();

          if (!materiel) {
            const { data: cat } = await supabase
              .from("categories")
              .select("nom")
              .eq("id_categorie", categorie_id)
              .maybeSingle();

            lignesRetirees.push(cat?.nom ?? categorie_id);
            continue;
          }
          const zone_id = (materiel.stocks as any)?.id_zone;
          if (!zone_id) continue;

          materielsAssignes.push({ materiel, zone_id });
        }
      }

      const parZone: Record<string, any[]> = {};
      for (const item of materielsAssignes) {
        if (!parZone[item.zone_id]) parZone[item.zone_id] = [];
        parZone[item.zone_id].push(item.materiel);
      }

      for (const [zone_id, materiels] of Object.entries(parZone)) {
        const { data: ticket, error: ticketError } = await supabase
          .from("tickets")
          .insert({
            lieu_utilisation,
            date_fin_prevue,
            etat: "EN_ATTENTE",
            id_demandeur: user.id,
            id_zone: zone_id,
          })
          .select()
          .single();

        if (ticketError || !ticket) continue;

        await supabase.from("lignes_ticket").insert(
          materiels.map((m: any) => ({
            id_ticket: ticket.id_ticket,
            id_materiel: m.id_materiel,
          }))
        );

        await supabase
          .from("materiels")
          .update({ etat: "EMPRUNTE" })
          .in("id_materiel", materiels.map((m: any) => m.id_materiel));

        ticketsCrees.push(ticket.id_ticket);

        const { data: techniciens } = await supabase
          .from("gerer")
          .select("id_utilisateur")
          .eq("id_zone", zone_id);

        if (techniciens && techniciens.length > 0) {
          await supabase.from("notifications").insert(
            techniciens.map((t: any) => ({
              message: "Nouvelle demande d'emprunt dans votre zone.",
              type: "NOUVELLE_DEMANDE",
              id_utilisateur: t.id_utilisateur,
            }))
          );
        }
      }

      if (lignesRetirees.length > 0) {
        await supabase.from("notifications").insert({
          message: `Matériels indisponibles retirés : ${lignesRetirees.join(", ")}.`,
          type: "LIGNES_RETIREES",
          id_utilisateur: user.id,
        });
      }

      return Response.json({
        tickets_crees: ticketsCrees,
        lignes_retirees: lignesRetirees,
      });

    } catch (e) {
      return Response.json({ error: String(e) }, { status: 500 });
    }
  }),
};

# generer-code-remise



// supabase/functions/generer-code-remise/index.ts
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "jsr:@supabase/server@^1";

const VALIDITE_HEURES = 24;

function genererCode(): string {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

export default {
  fetch: withSupabase({ auth: "user" }, async (req, { supabase }) => {
    try {
      const { ticket_id } = await req.json();

      if (!ticket_id) {
        return Response.json({ error: "ticket_id requis" }, { status: 400 });
      }

      const { data: ticket, error: ticketError } = await supabase
        .from("tickets")
        .select("*")
        .eq("id_ticket", ticket_id)
        .eq("etat", "EN_ATTENTE")
        .maybeSingle();

      if (ticketError) {
        return Response.json({ error: ticketError.message }, { status: 500 });
      }

      if (!ticket) {
        return Response.json(
          { error: "Ticket introuvable ou déjà traité" },
          { status: 404 }
        );
      }

      const { data: { user }, error: authError } = await supabase.auth.getUser();
      if (authError || !user) {
        return Response.json({ error: "Non authentifié" }, { status: 401 });
      }

      const code = genererCode();
      const expiration = new Date();
      expiration.setHours(expiration.getHours() + VALIDITE_HEURES);

      const { error: updateError } = await supabase
        .from("tickets")
        .update({
          etat: "VALIDE",
          code_remise: code,
          date_expiration_code: expiration.toISOString(),
          date_validation: new Date().toISOString(),
          id_valideur: user.id,
        })
        .eq("id_ticket", ticket_id);

      if (updateError) {
        return Response.json({ error: updateError.message }, { status: 500 });
      }

      await supabase.from("notifications").insert({
        message: `Demande validée. Code : ${code}. Récupérez sous ${VALIDITE_HEURES}h.`,
        type: "DEMANDE_VALIDEE",
        id_utilisateur: ticket.id_demandeur,
      });

      return Response.json({ code, expiration });

    } catch (e) {
      return Response.json({ error: String(e) }, { status: 500 });
    }
  }),
};



#  verifier-expiration-tickets



// supabase/functions/verifier-expiration-tickets/index.ts
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

const CONFIG = {
  SUPABASE_URL: Deno.env.get("SUPABASE_URL")!,
  SERVICE_ROLE_KEY: Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
};

Deno.serve(async (_req) => {
  try {
    // Service role pour bypass RLS (cron job)
    const supabase = createClient(
      CONFIG.SUPABASE_URL,
      CONFIG.SERVICE_ROLE_KEY
    );

    const maintenant = new Date().toISOString();

    // Trouver les tickets VALIDE expires
    const { data: ticketsExpires, error } = await supabase
      .from("tickets")
      .select("id_ticket, id_demandeur, lignes_ticket(id_materiel)")
      .eq("etat", "VALIDE")
      .lt("date_expiration_code", maintenant);

    if (error) throw error;
    if (!ticketsExpires || ticketsExpires.length === 0) {
      return Response.json({ message: "Aucun ticket expire", count: 0 });
    }

    for (const ticket of ticketsExpires) {
      // Passer le ticket à EXPIRe
      await supabase
        .from("tickets")
        .update({ etat: "EXPIRE" })
        .eq("id_ticket", ticket.id_ticket);

      // Remettre les materiels EN_STOCK
      const materielIds = (ticket.lignes_ticket as any[])
        .map((l) => l.id_materiel);

      await supabase
        .from("materiels")
        .update({ etat: "EN_STOCK" })
        .in("id_materiel", materielIds);

      // Notifier l'user
      await supabase.from("notifications").insert({
        message: "Votre demande a expire. Refaites une demande si besoin.",
        type: "TICKET_EXPIRe",
        id_utilisateur: ticket.id_demandeur,
      });
    }

    return Response.json({
      message: "Tickets expires traites",
      count: ticketsExpires.length,
    });

  } catch (e) {
    return Response.json(
      { error: String(e) },
      { status: 500 }
    );
  }
});



# verifier-expiration-affectations

// supabase/functions/verifier-expiration-affectations/index.ts
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

const CONFIG = {
  SUPABASE_URL: Deno.env.get("SUPABASE_URL")!,
  SERVICE_ROLE_KEY: Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  DELAI_NOTIF_AVANT_JOURS: 7,
};

Deno.serve(async (_req) => {
  try {
    const supabase = createClient(
      CONFIG.SUPABASE_URL,
      CONFIG.SERVICE_ROLE_KEY
    );

    const maintenant = new Date();
    const dans7Jours = new Date();
    dans7Jours.setDate(dans7Jours.getDate() + CONFIG.DELAI_NOTIF_AVANT_JOURS);

    // 1. Affectations expirees aujourd'hui
    const { data: expirees } = await supabase
      .from("affectations")
      .select("id_affectation, id_materiel, id_beneficiaire")
      .eq("etat", "ACTIVE")
      .lt("date_fin_prevue", maintenant.toISOString().split("T")[0]);

    if (expirees && expirees.length > 0) {
      for (const aff of expirees) {
        // Passer à EXPIReE
        await supabase
          .from("affectations")
          .update({ etat: "EXPIREE" })
          .eq("id_affectation", aff.id_affectation);

        // Materiel → EN_STOCK
        await supabase
          .from("materiels")
          .update({ etat: "EN_STOCK" })
          .eq("id_materiel", aff.id_materiel);

        // Recuperer les admins
        const { data: admins } = await supabase
          .from("utilisateurs")
          .select("id_utilisateur")
          .eq("role", "ADMIN");

        // Notifier admins + user
        const notifs = [
          {
            message: "Une affectation a expire. Action requise.",
            type: "AFFECTATION_EXPIReE",
            id_utilisateur: aff.id_beneficiaire,
          },
          ...(admins ?? []).map((a: any) => ({
            message: `L'affectation d'un utilisateur a expire. Renouvelez ou revoquez.`,
            type: "AFFECTATION_EXPIReE_ADMIN",
            id_utilisateur: a.id_utilisateur,
          })),
        ];

        await supabase.from("notifications").insert(notifs);
      }
    }

    // 2. Affectations qui expirent dans 7 jours
    const { data: bientôtExpirees } = await supabase
      .from("affectations")
      .select("id_affectation, id_beneficiaire")
      .eq("etat", "ACTIVE")
      .eq(
        "date_fin_prevue",
        dans7Jours.toISOString().split("T")[0]
      );

    if (bientôtExpirees && bientôtExpirees.length > 0) {
      for (const aff of bientôtExpirees) {
        const { data: admins } = await supabase
          .from("utilisateurs")
          .select("id_utilisateur")
          .eq("role", "ADMIN");

        const notifs = [
          {
            message: "Votre affectation expire dans 7 jours.",
            type: "AFFECTATION_BIENTÔT_EXPIReE",
            id_utilisateur: aff.id_beneficiaire,
          },
          ...(admins ?? []).map((a: any) => ({
            message: "Une affectation expire dans 7 jours. Pensez à la renouveler.",
            type: "AFFECTATION_BIENTÔT_EXPIReE_ADMIN",
            id_utilisateur: a.id_utilisateur,
          })),
        ];

        await supabase.from("notifications").insert(notifs);
      }
    }

    return Response.json({
      expirees: expirees?.length ?? 0,
      bientôt_expirees: bientôtExpirees?.length ?? 0,
    });

  } catch (e) {
    return Response.json(
      { error: String(e) },
      { status: 500 }
    );
  }
});


# creer-utilisateur


// supabase/functions/creer-utilisateur/index.ts
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

const CONFIG = {
  SUPABASE_URL: Deno.env.get("SUPABASE_URL")!,
  SERVICE_ROLE_KEY: Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
};

Deno.serve(async (req) => {
  try {
    const payload = await req.json();
    // Payload du webhook auth.users
    const { id, email } = payload.record;

    const supabase = createClient(
      CONFIG.SUPABASE_URL,
      CONFIG.SERVICE_ROLE_KEY
    );

    // Vérifier si l'utilisateur existe déjà
    const { data: existing } = await supabase
      .from("utilisateurs")
      .select("id_utilisateur")
      .eq("id_utilisateur", id)
      .single();

    if (existing) {
      return Response.json({ message: "Utilisateur déjà existant" });
    }

    // Créer la ligne dans utilisateurs
    // nom/prenom/role seront mis à jour par l'Admin
    const { error } = await supabase
      .from("utilisateurs")
      .insert({
        id_utilisateur: id,
        nom: email?.split("@")[0] ?? "Nouveau",
        prenom: "Utilisateur",
        role: "SIMPLE",
      });

    if (error) {
      return Response.json(
        { error: error.message },
        { status: 500 }
      );
    }

    return Response.json({ message: "Utilisateur créé", id });

  } catch (e) {
    return Response.json(
      { error: String(e) },
      { status: 500 }
    );
  }
});




