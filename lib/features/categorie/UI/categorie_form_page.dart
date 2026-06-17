import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../provider/categorie_provider.dart';
import '../../../shared/services/supabase_service.dart';

class CategorieFormPage extends ConsumerStatefulWidget {
  final String? id;
  final String? initialNom;
  final String? initialDesc;
  final String? initialImageUrl;

  const CategorieFormPage({
    super.key,
    this.id,
    this.initialNom,
    this.initialDesc,
    this.initialImageUrl,
  });

  @override
  ConsumerState<CategorieFormPage> createState() => _CategorieFormPageState();
}

class _CategorieFormPageState extends ConsumerState<CategorieFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _descController = TextEditingController();

  File? _selectedImage;
  String? _currentImageUrl;
  bool _isUploading = false;
  bool _imageRemoved = false; // ✅ Nouveau flag pour suivre la suppression

  @override
  void initState() {
    super.initState();
    _currentImageUrl = widget.initialImageUrl;
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

  Future<String?> _uploadImage(File image) async {
    try {
      final supabase = SupabaseService.client;
      final path = image.path;
      final fileName = path.split('/').last.split('\\').last;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final storagePath = 'categories/${timestamp}_$fileName';

      print('📤 Upload de l\'image : $storagePath');

      await supabase.storage.from('categorie_images').upload(
            storagePath,
            image,
          );

      final url = supabase.storage.from('categorie_images').getPublicUrl(storagePath);
      print('📎 URL publique : $url');

      return url;
    } catch (e) {
      print('❌ Erreur upload : $e');
      throw Exception('Erreur lors de l\'upload de l\'image : $e');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _currentImageUrl = null;
        _imageRemoved = false; // ✅ Une nouvelle image est sélectionnée
      });
    }
  }

  Future<void> _removeImage() async {
    setState(() {
      _selectedImage = null;
      _currentImageUrl = null;
      _imageRemoved = true; // ✅ Marquer que l'image a été supprimée
    });
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(categorieCrudProvider);
    final isEdit = widget.id != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Modifier la catégorie' : 'Créer une catégorie'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Image ──
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Image de la catégorie',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: _selectedImage != null
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    onPressed: _removeImage,
                                    icon: const Icon(Icons.close, color: Colors.white),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : _currentImageUrl != null && _currentImageUrl!.isNotEmpty
                              ? Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.network(
                                      _currentImageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.broken_image,
                                        size: 64,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: IconButton(
                                        onPressed: _removeImage,
                                        icon: const Icon(Icons.close, color: Colors.white),
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 48,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Aucune image sélectionnée',
                                      style: TextStyle(color: Colors.grey.shade500),
                                    ),
                                  ],
                                ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Wrap(
                        spacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _isUploading ? null : _pickImage,
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Choisir une image'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                          ),
                          if (_selectedImage != null ||
                              (_currentImageUrl != null && _currentImageUrl!.isNotEmpty))
                            TextButton(
                              onPressed: _isUploading ? null : _removeImage,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: const Text('Supprimer'),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ── Nom ──
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom de la catégorie *',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Veuillez saisir un nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ── Description ──
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

              if (_isUploading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: CircularProgressIndicator(),
                ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: actionState.isLoading || _isUploading
                      ? null
                      : () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final messenger = ScaffoldMessenger.of(context);
                            final navigator = Navigator.of(context);

                            try {
                              String? imageUrl;

                              // ✅ Cas 1 : Une nouvelle image a été sélectionnée
                              if (_selectedImage != null) {
                                setState(() => _isUploading = true);
                                imageUrl = await _uploadImage(_selectedImage!);
                                setState(() => _isUploading = false);
                              }
                              // ✅ Cas 2 : L'image a été supprimée (imageRemoved = true)
                              else if (_imageRemoved) {
                                imageUrl = null; // Forcer la suppression
                              }
                              // ✅ Cas 3 : Aucun changement, garder l'image existante
                              else if (_currentImageUrl != null && _currentImageUrl!.isNotEmpty) {
                                imageUrl = _currentImageUrl;
                              }

                              final data = <String, dynamic>{
                                'nom': _nomController.text.trim(),
                                'description': _descController.text.trim(),
                              };

                              // ✅ Ajouter l'URL seulement si elle n'est pas null
                              // Si imageUrl est null, on ne met pas le champ dans data
                              // pour éviter de l'envoyer (mais on veut le mettre à null si supprimé)
                              if (imageUrl != null) {
                                data['image_url'] = imageUrl;
                              } else if (_imageRemoved) {
                                // ✅ Forcer la mise à null si l'image a été supprimée
                                data['image_url'] = null;
                              }

                              print('📦 Données envoyées : $data');

                              if (isEdit) {
                                await ref
                                    .read(categorieCrudProvider.notifier)
                                    .updateCategorie(widget.id!, data);
                                messenger.showSnackBar(
                                  const SnackBar(
                                    content: Text('Catégorie mise à jour'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                await ref.read(categorieCrudProvider.notifier).create(data);
                                messenger.showSnackBar(
                                  const SnackBar(
                                    content: Text('Catégorie créée'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                              navigator.pop();
                            } catch (e) {
                              setState(() => _isUploading = false);
                              print('❌ Erreur : $e');
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text('Erreur : $e'),
                                  backgroundColor: Colors.red,
                                ),
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