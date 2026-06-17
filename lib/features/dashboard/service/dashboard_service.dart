import 'package:materelia/shared/services/supabase_service.dart';

class DashboardStats {
  final int totalMateriels;
  final int materielsEnStock;
  final int materielsAffectes;
  final int materielsEmpruntes;
  final int materielsEnPanne;
  final int materielsReformes;
  final int totalUtilisateurs;
  final int totalTechniciens;
  final int totalAdmins;
  final int demandesEnAttente;
  final int affectationsActives;
  final int ticketsEnAttente;
  final int ticketsEnCours;
  final int totalZones;
  final int totalCategories;

  const DashboardStats({
    required this.totalMateriels,
    required this.materielsEnStock,
    required this.materielsAffectes,
    required this.materielsEmpruntes,
    required this.materielsEnPanne,
    required this.materielsReformes,
    required this.totalUtilisateurs,
    required this.totalTechniciens,
    required this.totalAdmins,
    required this.demandesEnAttente,
    required this.affectationsActives,
    required this.ticketsEnAttente,
    required this.ticketsEnCours,
    required this.totalZones,
    required this.totalCategories,
  });
}

class DashboardService {
  final _db = SupabaseService.client;

  Future<DashboardStats> getStats() async {
    final results = await Future.wait([
      _db.from('materiels').select('etat'),
      _db.from('utilisateurs').select('role'),
      _db.from('demandes_affectation').select('etat').eq('etat', 'EN_ATTENTE'),
      _db.from('affectations').select('etat').eq('etat', 'ACTIVE'),
      _db.from('tickets').select('etat'),
      _db.from('zones').select('id_zone'),
      _db.from('categories').select('id_categorie'),
    ]);

    final materiels = results[0] as List;
    final utilisateurs = results[1] as List;
    final tickets = results[4] as List;

    return DashboardStats(
      totalMateriels: materiels.length,
      materielsEnStock: materiels.where((m) => m['etat'] == 'EN_STOCK').length,
      materielsAffectes: materiels.where((m) => m['etat'] == 'AFFECTE').length,
      materielsEmpruntes: materiels
          .where((m) => m['etat'] == 'EMPRUNTE')
          .length,
      materielsEnPanne: materiels.where((m) => m['etat'] == 'EN_PANNE').length,
      materielsReformes: materiels.where((m) => m['etat'] == 'REFORME').length,
      totalUtilisateurs: utilisateurs
          .where((u) => u['role'] == 'SIMPLE')
          .length,
      totalTechniciens: utilisateurs
          .where((u) => u['role'] == 'TECHNICIEN')
          .length,
      totalAdmins: utilisateurs.where((u) => u['role'] == 'ADMIN').length,
      demandesEnAttente: (results[2] as List).length,
      affectationsActives: (results[3] as List).length,
      ticketsEnAttente: tickets.where((t) => t['etat'] == 'EN_ATTENTE').length,
      ticketsEnCours: tickets.where((t) => t['etat'] == 'EN_COURS').length,
      totalZones: (results[5] as List).length,
      totalCategories: (results[6] as List).length,
    );
  }
}
