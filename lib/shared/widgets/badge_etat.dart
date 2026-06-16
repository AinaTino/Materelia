import 'package:flutter/material.dart';

enum BadgeEtatType { primary, secondary, warning, error, success }

extension BadgeEtatStyle on BadgeEtatType {
  ({Color text, Color bg}) get colors {
    switch (this) {
      case BadgeEtatType.primary:
        return (text: Color(0xFF1565C0), bg: Color(0xFFE3F2FD));

      case BadgeEtatType.secondary:
        return (text: Color(0xFF6A1B9A), bg: Color(0xFFF3E5F5));

      case BadgeEtatType.success:
        return (text: Color(0xFF2E7D32), bg: Color(0xFFE8F5E9));

      case BadgeEtatType.warning:
        return (text: Color(0xFFE65100), bg: Color(0xFFFFF3E0));

      case BadgeEtatType.error:
        return (text: Color(0xFFC62828), bg: Color(0xFFFFEBEE));
    }
  }
}

class BadgeEtat extends StatelessWidget {
  final BadgeEtatType etat;
  final String label;
  const BadgeEtat({super.key, required this.etat, required this.label});

  @override
  Widget build(BuildContext context) {
    final style = etat.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(color: style.text, fontWeight: FontWeight.w600),
      ),
    );
  }
}
