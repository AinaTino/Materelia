import 'package:materelia/features/auth/auth_exception.dart';

void verifyMail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (email.isEmpty) {
    throw EmailErrorException('Le email ne peut pas être vide');
  }
  if (!emailRegex.hasMatch(email)) {
    throw EmailErrorException('Le email est non valide');
  }
}

void verifyPassword(String password) {
  if (password.isEmpty) {
    throw PasswordErrorException('Le mot de passe ne peut pas être vide');
  }
  if (password.length < 8) {
    throw PasswordErrorException('Le mot de passe doit contenir au moins 8 caractères');
  }
}

void verifyName(String name) {
  final nameRegex = RegExp(r"^[a-zA-Z']+$");
  if (name.isEmpty) {
    throw NameErrorException('Le nom ne peut pas être vide');
  }
  if (name.length < 2) {
    throw NameErrorException('Le nom doit contenir au moins 2 caractères');
  }
  if (!nameRegex.hasMatch(name)) {
    throw NameErrorException('Le nom contient des caractères non valides');
  }
}

void verifyFirstName(String firstName) {
  final nameRegex = RegExp(r"^[a-zA-Z']+$");
  if (firstName.isEmpty) {
    throw FirstNameErrorException('Le prénom ne peut pas être vide');
  }
  if (firstName.length < 2) {
    throw FirstNameErrorException('Le prénom doit contenir au moins 2 caractères');
  }
  if (!nameRegex.hasMatch(firstName)) {
    throw FirstNameErrorException('Le prénom contient des caractères non valides');
  }
}