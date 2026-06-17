# Documentation projet - Materelia

Date d'analyse : 17 juin 2026  
Projet : application Flutter de gestion de materiels informatiques  
Backend : Supabase, avec tables relationnelles et Edge Functions

## 1. A propos de l'application

Materelia est une application de gestion de parc informatique. Elle permet de gerer les materiels, les categories, les stocks, les zones, les utilisateurs, les demandes d'emprunt, les affectations longues durees et les notifications.

L'application distingue trois niveaux d'utilisation :

- `SIMPLE` : utilisateur demandeur.
- `TECHNICIEN` : utilisateur pouvant aussi traiter les tickets de sa zone.
- `ADMIN` : utilisateur pouvant aussi administrer le referentiel, les affectations et les roles.

Le parcours central est le suivant :

1. Un utilisateur choisit des categories de materiels disponibles dans le catalogue.
2. Il valide son panier avec un lieu d'utilisation et une date de fin prevue.
3. Une Edge Function Supabase cree un ou plusieurs tickets, regroupes par zone.
4. Les techniciens de la zone recoivent une notification.
5. Un technicien valide, refuse, remet le materiel ou confirme son retour.
6. Les etats des tickets et des materiels sont mis a jour.

Un second parcours permet de demander une affectation longue duree. Cette demande est traitee par un administrateur, qui choisit un materiel disponible, cree une affectation, puis peut ensuite renouveler ou revoquer cette affectation.

## 2. Stack technique

### Frontend

- Flutter / Dart.
- Riverpod pour l'etat applicatif.
- GoRouter pour la navigation.
- Freezed et JSON Serializable pour les modeles immuables et la serialisation.
- Google Fonts pour la typographie.
- Image Picker pour les images de categories ou de materiels selon les ecrans.

### Backend

- Supabase Auth pour l'authentification.
- Supabase Database pour les tables metier.
- Supabase Edge Functions pour certains traitements critiques.
- Notifications stockees en table `notifications`.

### Plateformes presentes dans le projet

- Android.
- Windows.

## 3. Configuration et lancement

Le fichier `.env` est charge au demarrage par `flutter_dotenv`.

Variables attendues :

```env
SUPABASE_URL=...
SUPABASE_ANON_KEY=...
```

Commandes utiles :

```bash
flutter pub get
flutter run
flutter test
flutter analyze
```

Generation des fichiers Freezed/Riverpod/JSON :

```bash
dart run build_runner build --delete-conflicting-outputs
```

Remarque : lors de cette analyse, `flutter analyze` n'a pas termine apres 120 secondes. Il faudra le relancer dans un environnement local stable pour obtenir la liste complete des erreurs et avertissements.

## 4. Architecture du projet

La structure est organisee par fonctionnalite :

```text
lib/
  core/
    constants/
    router/
    shell/
    theme/
  features/
    auth/
    dashboard/
    panier/
    ticket/
    materiel/
    categorie/
    stock/
    zone/
    utilisateurs/
    affectations/
    demandes_affectations/
    mes_affectations/
    mes_demandes/
    notifications/
    profile/
  shared/
    models/
    services/
    tools/
    widgets/
```

Convention observee dans les features :

- `UI/` contient les pages Flutter.
- `service/` contient les appels Supabase et la logique metier.
- `provider/` contient les providers Riverpod.
- `widgets/` contient les composants propres a la feature.

Les composants communs sont dans `shared/widgets`. Les modeles communs sont dans `shared/models`.

## 5. Navigation

Le point d'entree est `lib/main.dart`. Il initialise Flutter, charge `.env`, initialise Supabase, puis lance `MateReliaApp`.

Le routeur principal est dans `lib/core/router/app_router.dart`.

Routes publiques :

- `/signin`
- `/signup`
- `/callback`

Routes protegees :

- `/catalogue`
- `/panier`
- `/mes-tickets`
- `/mes-affectations`
- `/mes-demandes`
- `/tickets-zone`
- `/historique`
- `/dashboard`
- `/affectations`
- `/demandes-affectations`
- `/materiels`
- `/utilisateurs`
- `/zones`
- `/stocks`
- `/categories`
- `/mon-profil`
- `/notifications`

La redirection fonctionne ainsi :

- `/` redirige vers `/catalogue` si une session existe.
- `/` redirige vers `/signin` si aucune session n'existe.
- Un utilisateur non connecte est renvoye vers `/signin`.
- Un utilisateur connecte qui ouvre `/signin` ou `/signup` est renvoye vers `/catalogue`.

La navigation laterale est adaptee au role dans `SidebarRail` et `SidebarDrawer`.

## 6. Roles et workflows

### Role SIMPLE

Un utilisateur simple peut :

- se connecter et creer un compte ;
- consulter le catalogue ;
- ajouter des categories de materiels dans son panier ;
- valider une demande d'emprunt ;
- consulter ses tickets ;
- consulter ses affectations ;
- creer une demande d'affectation ;
- consulter ses demandes d'affectation ;
- consulter ses notifications ;
- consulter/modifier son profil selon les capacites de l'ecran profil.

Workflow d'emprunt :

1. Aller dans `Catalogue`.
2. Choisir les categories disponibles.
3. Aller dans `Panier`.
4. Saisir le lieu d'utilisation et la date de fin prevue.
5. Valider.
6. L'application appelle l'Edge Function `assigner-materiels`.
7. Des tickets sont crees par zone.
8. L'utilisateur suit l'etat dans `Mes Tickets`.

Workflow de demande d'affectation :

1. Aller dans `Mes demandes d'affectation`.
2. Creer une demande avec justification, service beneficiaire et categorie.
3. Attendre la validation ou le refus admin.
4. Consulter le resultat dans `Mes demandes` et/ou `Mes affectations`.

### Role TECHNICIEN

Un technicien herite du role simple et peut aussi :

- consulter les tickets de sa zone ;
- valider ou refuser les tickets ;
- confirmer la remise physique du materiel ;
- confirmer le retour physique ;
- consulter l'historique.

Workflow de ticket :

1. Aller dans `Tickets Zone`.
2. Ouvrir un ticket lie a une zone geree.
3. Valider ou refuser la demande.
4. En cas de validation, un code de remise peut etre utilise selon le flux Edge Function.
5. Confirmer la remise lorsque l'utilisateur vient retirer le materiel.
6. Confirmer le retour lorsque le materiel revient.
7. Le materiel repasse en stock apres retour.

La table `gerer` relie un technicien a une zone :

```text
gerer(id_utilisateur, id_zone)
```

### Role ADMIN

Un administrateur herite des roles precedents et peut aussi :

- consulter le dashboard ;
- gerer les utilisateurs et leurs roles ;
- assigner ou retirer une zone a un technicien ;
- gerer les materiels ;
- gerer les categories ;
- gerer les zones ;
- gerer les stocks ;
- consulter et gerer les affectations ;
- valider ou refuser les demandes d'affectation ;
- renouveler ou revoquer une affectation.

Workflow d'affectation admin :

1. Aller dans `Demandes d'affectation`.
2. Ouvrir une demande.
3. Choisir un materiel disponible dans la categorie demandee.
4. Valider la demande.
5. L'application passe le materiel a `AFFECTE`.
6. Une ligne est creee dans `affectations`.
7. Le demandeur recoit une notification.

Workflow administration du parc :

1. Creer les zones.
2. Creer les stocks rattaches a ces zones.
3. Creer les categories.
4. Ajouter les materiels avec categorie, stock, reference et etat.
5. Assigner les techniciens aux zones.
6. Suivre les statistiques dans le dashboard.

## 7. Etats metier

### Materiels

- `EN_STOCK`
- `EMPRUNTE`
- `AFFECTE`
- `EN_PANNE`
- `REFORME`

### Tickets

- `EN_ATTENTE`
- `VALIDE`
- `EN_COURS`
- `RENDU`
- `EXPIRE`
- `REFUSE`

### Affectations

- `ACTIVE`
- `EXPIREE`
- `REVOQUEE`

## 8. Modele de donnees

Tables principales documentees dans `db.md` :

- `utilisateurs`
- `zones`
- `stocks`
- `categories`
- `materiels`
- `gerer`
- `tickets`
- `lignes_ticket`
- `demandes_affectation`
- `affectations`
- `notifications`

Relations importantes :

- Un stock appartient a une zone via `stocks.id_zone`.
- Un materiel appartient a une categorie et a un stock.
- Un ticket appartient a un demandeur et a une zone.
- Un ticket contient plusieurs lignes via `lignes_ticket`.
- Une demande d'affectation appartient a un demandeur et a une categorie.
- Une affectation relie un materiel, un beneficiaire et une demande.
- Un technicien gere une zone via `gerer`.
- Une notification appartient a un utilisateur.

## 9. Edge Functions Supabase

Le fichier `edge_function.md` documente plusieurs fonctions.

### `assigner-materiels`

Utilisee par le panier. Elle :

- verifie l'utilisateur connecte ;
- recoit des lignes `{ categorie_id, nombre }` ;
- cherche des materiels `EN_STOCK` ;
- regroupe les materiels par zone ;
- cree un ticket par zone ;
- cree les lignes de ticket ;
- notifie les techniciens de la zone ;
- notifie l'utilisateur si certaines lignes sont devenues indisponibles.

### `generer-code-remise`

Elle :

- recoit un `ticket_id` ;
- verifie que le ticket est `EN_ATTENTE` ;
- genere un code a 6 chiffres ;
- passe le ticket a `VALIDE` ;
- stocke l'expiration du code ;
- notifie le demandeur.

### `verifier-expiration-tickets`

Fonction de type cron. Elle :

- cherche les tickets `VALIDE` dont le code est expire ;
- passe les tickets a `EXPIRE` ;
- remet les materiels en `EN_STOCK` ;
- notifie l'utilisateur.

### `verifier-expiration-affectations`

Fonction de type cron. Elle :

- passe les affectations depassees a `EXPIREE` ;
- remet le materiel en `EN_STOCK` ;
- notifie l'utilisateur et les admins ;
- notifie aussi les affectations qui expirent bientot.

### `creer-utilisateur`

Fonction liee au webhook Auth. Elle cree une ligne dans `utilisateurs` lorsqu'un compte Supabase Auth est cree.

## 10. Services applicatifs importants

- `AuthService` : connexion, inscription, deconnexion.
- `SupabaseService` : acces centralise au client Supabase et aux Edge Functions.
- `PanierService` : categories disponibles, materiels par categorie, validation du panier.
- `TicketService` : tickets utilisateur, tickets zone, validation/refus/remise/retour.
- `DemandesAffectationsService` : validation/refus des demandes d'affectation.
- `MesDemandesService` : creation et consultation des demandes de l'utilisateur.
- `AffectationsService` : liste, detail, renouvellement et revocation.
- `MaterielService` : CRUD materiels, suppression logique par passage a `REFORME`.
- `CategorieService` : CRUD categories.
- `ZoneService` : CRUD zones.
- `StockService` : CRUD stocks.
- `UtilisateursService` : liste utilisateurs, changement de role, assignation de zone.
- `NotificationsService` : lecture, marquage lu, suppression, creation de notifications.
- `DashboardService` : statistiques admin.

## 11. Documentation existante

Fichiers utiles deja presents :

- `README.md` : presentation tres courte du projet.
- `gestion_materiels_conception.md` : document de conception complet, avec acteurs, regles metier, UML/Merise et architecture.
- `db.md` : structure des tables Supabase.
- `edge_function.md` : code/documentation des Edge Functions.
- `structure.txt` et `arborescence.txt` : vues de l'arborescence.
- `notre_version.txt` et `tino_version.txt` : notes/versionnements internes.

Cette documentation peut servir de point d'entree plus operationnel pour reprendre le projet.

## 12. Points d'attention techniques

### Incoherences schema / code

Plusieurs ecarts doivent etre verifies :

- `db.md` indique `tickets.code_remise` en `varchar`, mais le modele Dart `Ticket` le type en `int?`.
- `NotificationsService.envoyerNotif` insere un champ `route`, mais `db.md` ne liste pas `route` dans la table `notifications`.
- `DemandesAffectationsService.validerDemande` met a jour `date_action`, mais `db.md` ne liste pas cette colonne dans `demandes_affectation`.

Ces ecarts peuvent provoquer des erreurs runtime Supabase si la base ne contient pas les colonnes attendues.

### Etat des materiels dans le flux ticket

L'Edge Function `assigner-materiels` passe les materiels a `EMPRUNTE` des la creation du ticket. Ensuite le service Dart de remise passe aussi les materiels a `EMPRUNTE`.

Selon la regle metier attendue, il faut clarifier si un materiel doit etre :

- reserve des la demande ;
- ou rester disponible jusqu'a validation/remise ;
- ou passer dans un etat intermediaire non present actuellement.

Sans etat intermediaire, le stock peut etre bloque avant validation effective.

### Encodage

Plusieurs fichiers affichent des caracteres mal encodes (`MatÃ©riels`, `RÃ´les`, etc.). Cela n'empeche pas toujours la compilation, mais degrade l'interface et la documentation. Il faudrait normaliser l'encodage en UTF-8.

### Analyse statique

`flutter analyze` a ete lance pendant cette analyse mais a depasse 120 secondes. A refaire avant livraison.

## 13. Recommandations de reprise

Priorite 1 :

- Verifier les colonnes reelles Supabase face aux services Dart.
- Relancer `flutter analyze`.
- Relancer la generation `build_runner` si les modeles/providers ont change.

Priorite 2 :

- Clarifier le cycle d'etat des materiels lors d'une demande d'emprunt.
- Harmoniser le flux de generation du code de remise entre Edge Function et service Dart.
- Nettoyer les problemes d'encodage.

Priorite 3 :

- Completer les tests autour des services critiques.
- Documenter les politiques RLS Supabase.
- Ajouter une documentation de deploiement des Edge Functions et des jobs cron.

## 14. Resume rapide pour un nouveau developpeur

Materelia est une app Flutter connectee a Supabase pour gerer l'emprunt et l'affectation de materiels informatiques. Le frontend est organise par feature, Riverpod gere l'etat, GoRouter gere la navigation, et Supabase porte l'authentification, les donnees et certaines operations metier via Edge Functions.

Les trois roles sont `SIMPLE`, `TECHNICIEN` et `ADMIN`. Le role simple demande des materiels ou des affectations. Le technicien traite les tickets de sa zone. L'admin gere le referentiel, les roles, les affectations et le dashboard.

Avant toute evolution, verifier la coherence entre le schema Supabase, les modeles Dart, les services et les Edge Functions. Les points les plus sensibles sont les colonnes `route` et `date_action`, le type de `code_remise`, et le moment exact ou un materiel doit passer a `EMPRUNTE`.
