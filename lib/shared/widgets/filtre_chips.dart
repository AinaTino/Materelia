import 'package:flutter/material.dart';

class FiltreChips extends StatelessWidget {
  final String? filtreActif;
  final Map<String, String> etats;
  final ValueChanged<String?> onFiltreChange;

  const FiltreChips({
    super.key,
    required this.filtreActif,
    required this.etats,
    required this.onFiltreChange,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Toutes'),
            selected: filtreActif == null,
            onSelected: (_) => onFiltreChange(null),
          ),
          const SizedBox(width: 6),
          ...etats.entries.map(
            (e) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: FilterChip(
                label: Text(e.value),
                selected: filtreActif == e.key,
                onSelected: (_) =>
                    onFiltreChange(filtreActif == e.key ? null : e.key),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
