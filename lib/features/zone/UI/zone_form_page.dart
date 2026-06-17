import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/zone_provider.dart';

class ZoneFormPage extends ConsumerStatefulWidget {
  final String? id;
  final String? initialNom;
  final String? initialDesc;

  const ZoneFormPage({super.key, this.id, this.initialNom, this.initialDesc});

  @override
  ConsumerState<ZoneFormPage> createState() => _ZoneFormPageState();
}

class _ZoneFormPageState extends ConsumerState<ZoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialNom != null) {
      _nomController.text = widget.initialNom!;
    }
    if (widget.initialDesc != null) {
      _descController.text = widget.initialDesc!;
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(zoneCrudProvider);
    final isEdit = widget.id != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Modifier la zone' : 'Créer une zone'),
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
                  labelText: 'Nom de la zone *',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Veuillez saisir un nom';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
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
                              'description': _descController.text.trim(),
                            };

                            try {
                              if (isEdit) {
                                await ref.read(zoneCrudProvider.notifier).updateZone(widget.id!, data);
                                messenger.showSnackBar(
                                  const SnackBar(content: Text('Zone mise à jour')),
                                );
                              } else {
                                await ref.read(zoneCrudProvider.notifier).create(data);
                                messenger.showSnackBar(
                                  const SnackBar(content: Text('Zone créée')),
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
