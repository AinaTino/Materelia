import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  // Supabase
  static final String supabaseUrl = dotenv.get('SUPABASE_URL');
  static final String supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');

  // Métier
  static const int validiteDemandeHeures = 24;
  static const int dureeAffectationJours = 90;
  static const int delaiNotifAvantJours = 7;

  // Rôles
  static const String roleSimple = 'SIMPLE';
  static const String roleTechnicien = 'TECHNICIEN';
  static const String roleAdmin = 'ADMIN';

  // États matériels
  static const String etatEnStock = 'EN_STOCK';
  static const String etatEmprunte = 'EMPRUNTE';
  static const String etatAffecte = 'AFFECTE';
  static const String etatEnPanne = 'EN_PANNE';
  static const String etatReforme = 'REFORME';

  // États tickets
  static const String ticketEnAttente = 'EN_ATTENTE';
  static const String ticketValide = 'VALIDE';
  static const String ticketEnCours = 'EN_COURS';
  static const String ticketRendu = 'RENDU';
  static const String ticketExpire = 'EXPIRE';
  static const String ticketRefuse = 'REFUSE';

  // États affectations
  static const String affectationActive = 'ACTIVE';
  static const String affectationExpiree = 'EXPIREE';
  static const String affectationRevoquee = 'REVOQUEE';
}