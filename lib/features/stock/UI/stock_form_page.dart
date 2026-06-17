import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../zone/provider/zone_provider.dart';
import '../provider/stock_provider.dart';

class StockFormPage extends ConsumerStatefulWidget {
  final String? id;
  final String? initialNom;
  final String? initialZoneId;

  const StockFormPage({super.key, this.id, this.initialNom, this.initialZoneId});

  @override
  ConsumerState<StockFormPage> createState() => _StockFormPageState();
}

class _StockFormPageState extends ConsumerState<StockFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  String? _selectedZoneId;

  @override
  void initState() {
    super.initState();
    if (widget.initialNom != null) {
      _nomController.text = widget.initialNom!;
    }
    _selectedZoneId = widget.initialZoneId;
  }

  @override
  void dispose() {
    _nomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(stockCrudProvider);
    final zonesAsync = ref.watch(zonesProvider);
    final isEdit = widget.id != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Modifier le stock' : 'Créer un stock'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom du stock *',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Veuillez saisir un nom';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Zones selector dropdown
              zonesAsync.when(
                data: (zones) => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Zone de rattachement *',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedZoneId,
                  onChanged: (val) => setState(() => _selectedZoneId = val),
                  items: zones
                      .map((z) => DropdownMenuItem<String>(
                            value: z['id_zone']?.toString(),
                            child: Text(z['nom']?.toString() ?? ''),
                          ))
                      .toList(),
                  validator: (val) => val == null ? 'Veuillez choisir une zone' : null,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Erreur zones : $e'),
              ),
              const SizedBox(height: 32),

              if (actionState.hasError)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Erreur : ${actionState.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: actionState.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final messenger = ScaffoldMessenger.of(context);
                            final navigator = Navigator.of(context);
                            final data = {
                              'nom': _nomController.text.trim(),
                              'id_zone': _selectedZoneId,
                            };

                            try {
                              if (isEdit) {
                                await ref.read(stockCrudProvider.notifier).updateStock(widget.id!, data);
                                messenger.showSnackBar(
                                  const SnackBar(content: Text('Stock mis à jour')),
                                );
                              } else {
                                await ref.read(stockCrudProvider.notifier).create(data);
                                messenger.showSnackBar(
                                  const SnackBar(content: Text('Stock créé')),
                                );
                              }
                              navigator.pop();
                            } catch (e) {
                              messenger.showSnackBar(
                                SnackBar(content: Text('Erreur : $e')),
                              );
                            }
                          }
                        },
                  child: actionState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(isEdit ? 'Enregistrer' : 'Créer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
