import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import '../provider/materiel_provider.dart';

class MaterielFormPage extends ConsumerStatefulWidget {
  final String? id; // Null in creation mode, contains ID in edit mode
  const MaterielFormPage({super.key, this.id});

  @override
  ConsumerState<MaterielFormPage> createState() => _MaterielFormPageState();
}

class _MaterielFormPageState extends ConsumerState<MaterielFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _refController = TextEditingController();
  final _descController = TextEditingController();

  String? _selectedCategorieId;
  String? _selectedStockId;
  DateTime? _dateAcquisition;
  bool _isInit = false;

  @override
  void dispose() {
    _nomController.dispose();
    _refController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit && widget.id != null) {
      // Fetch details and pre-fill fields
      ref.read(materielDetailProvider(widget.id!)).whenData((mat) {
        if (mat != null) {
          setState(() {
            _nomController.text = mat['nom']?.toString() ?? '';
            _refController.text = mat['reference']?.toString() ?? '';
            _descController.text = mat['description']?.toString() ?? '';
            _selectedCategorieId = mat['id_categorie']?.toString();
            _selectedStockId = mat['id_stock']?.toString();
            final dateRaw = mat['date_acquisition']?.toString();
            if (dateRaw != null) {
              _dateAcquisition = DateTime.parse(dateRaw);
            }
            _isInit = true;
          });
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateAcquisition ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _dateAcquisition) {
      setState(() {
        _dateAcquisition = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final stocksAsync = ref.watch(stocksProvider);
    final actionState = ref.watch(materielCrudProvider);

    final isEditMode = widget.id != null;
    final dateStr = _dateAcquisition != null
        ? '${_dateAcquisition!.day.toString().padLeft(2, '0')}/${_dateAcquisition!.month.toString().padLeft(2, '0')}/${_dateAcquisition!.year}'
        : 'Sélectionner la date d\'acquisition *';

    return profileAsync.when(
      data: (user) {
        final isAdmin = user.role == AppConstants.roleAdmin;
        return Scaffold(
          appBar: AppBar(
            title: Text(isEditMode ? 'Modifier le matériel' : 'Ajouter un matériel'),
            elevation: 0,
          ),
          body: isAdmin
              ? Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nomController,
                          decoration: const InputDecoration(
                            labelText: 'Nom du matériel *',
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return 'Ce champ est requis';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _refController,
                          decoration: const InputDecoration(
                            labelText: 'Référence unique *',
                            border: OutlineInputBorder(),
                            hintText: 'Ex: PC-HP-0092',
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return 'Ce champ est requis';
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
                        const SizedBox(height: 16),

                        categoriesAsync.when(
                          data: (cats) => DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Catégorie *',
                              border: OutlineInputBorder(),
                            ),
                            initialValue: _selectedCategorieId,
                            onChanged: (val) => setState(() => _selectedCategorieId = val),
                            items: cats
                                .map((c) => DropdownMenuItem<String>(
                                      value: c['id_categorie']?.toString(),
                                      child: Text(c['nom']?.toString() ?? ''),
                                    ))
                                .toList(),
                            validator: (val) => val == null ? 'Veuillez choisir une catégorie' : null,
                          ),
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (e, _) => Text('Erreur catégories : $e'),
                        ),
                        const SizedBox(height: 16),

                        stocksAsync.when(
                          data: (stocks) => DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Stock de rattachement *',
                              border: OutlineInputBorder(),
                            ),
                            initialValue: _selectedStockId,
                            onChanged: (val) => setState(() => _selectedStockId = val),
                            items: stocks
                                .map((s) => DropdownMenuItem<String>(
                                      value: s['id_stock']?.toString(),
                                      child: Text(s['nom']?.toString() ?? ''),
                                    ))
                                .toList(),
                            validator: (val) => val == null ? 'Veuillez choisir un stock' : null,
                          ),
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (e, _) => Text('Erreur stocks : $e'),
                        ),
                        const SizedBox(height: 16),

                        InkWell(
                          onTap: () => _selectDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dateStr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _dateAcquisition == null ? Colors.grey[600] : Colors.black,
                                  ),
                                ),
                                const Icon(Icons.calendar_today),
                              ],
                            ),
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
                                    if (_dateAcquisition == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Veuillez sélectionner la date d\'acquisition')),
                                      );
                                      return;
                                    }

                                    if (_formKey.currentState?.validate() ?? false) {
                                      final messenger = ScaffoldMessenger.of(context);
                                      final navigator = Navigator.of(context);

                                      final data = {
                                        'nom': _nomController.text.trim(),
                                        'reference': _refController.text.trim(),
                                        'description': _descController.text.trim(),
                                        'id_categorie': _selectedCategorieId,
                                        'id_stock': _selectedStockId,
                                        'date_acquisition': _dateAcquisition!.toIso8601String().split('T')[0],
                                        'etat': isEditMode ? null : 'EN_STOCK',
                                      }..removeWhere((key, value) => value == null);

                                      try {
                                        if (isEditMode) {
                                          await ref.read(materielCrudProvider.notifier).updateMateriel(widget.id!, data);
                                          messenger.showSnackBar(
                                            const SnackBar(content: Text('Le matériel a été mis à jour')),
                                          );
                                        } else {
                                          await ref.read(materielCrudProvider.notifier).create(data);
                                          messenger.showSnackBar(
                                            const SnackBar(content: Text('Le matériel a été ajouté avec succès')),
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
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : Text(isEditMode ? 'Enregistrer' : 'Créer'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.lock_outline, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Accès interdit',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Vous n\'avez pas les droits pour modifier ou ajouter un matériel.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Erreur profil : $e'))),
    );
  }
}
