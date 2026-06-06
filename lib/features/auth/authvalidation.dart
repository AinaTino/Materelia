void verifyMail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (email.isEmpty) {
    throw FormatException('Le email ne peut pas être vide');
  }
  if (!emailRegex.hasMatch(email)) {
    throw FormatException('Le email est non valide');
  }
}

void verifyPassword(String password) {
  if (password.isEmpty) {
    throw FormatException('Le mot de passe ne peut pas être vide');
  }
  if (password.length < 8) {
    throw FormatException('Le mot de passe doit contenir au moins 8 caractères');
  }
}

