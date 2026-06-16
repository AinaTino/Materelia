import 'package:flutter/material.dart';

class DetailPanel extends StatelessWidget {
  final VoidCallback onClose;
  final Widget child;
  final String type;

  const DetailPanel({
    super.key,
    required this.onClose,
    required this.child,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.close), onPressed: onClose),
                Text(
                  'Détail $type',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Contenu
          Expanded(child: child),
        ],
      ),
    );
  }
}
