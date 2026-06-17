import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/features/auth/service/auth_exception.dart';
import 'package:materelia/features/auth/provider/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nomController;
  late final TextEditingController _prenomController;
  late final TextEditingController _confirmPasswordController;
  bool _obscurePassword = true;
  String? _emailErrorText;
  String? _confirmPasswordErrorText;
  String? _generalErrorText;
  String? _nomErrorText;
  String? _prenomErrorText;
  String _selectedRole = AppConstants.roleSimple;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController();
    _prenomController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _emailErrorText = null;
      _confirmPasswordErrorText = null;
      _generalErrorText = null;
    });

    final authNotifier = ref.read(authControllerProvider.notifier);
    await authNotifier.signUp(
      nom: _nomController.text.trim(),
      prenom: _prenomController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      passwordConfirmation: _confirmPasswordController.text,
      role: _selectedRole,
    );

    final state = ref.read(authControllerProvider);
    if (state.hasError) {
      final error = state.error;
      if (error is NameErrorException) {
        setState(() {
          _nomErrorText = error.message;
        });
      } else if (error is FirstNameErrorException) {
        setState(() {
          _prenomErrorText = error.message;
        });
      }
      if (error is EmailErrorException) {
        setState(() {
          _emailErrorText = error.message;
        });
      } else if (error is PasswordErrorException) {
        setState(() {
          _confirmPasswordErrorText = error.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    // Écoute les erreurs et redirige en cas de succès
    ref.listen(authControllerProvider, (_, next) {
      next.whenOrNull(
        data: (_) => _generalErrorText = "Inscription réussie ! Veuillez confimer votre inscription via le lien envoyé à votre adresse email",
        error: (e, _) {
          if (e is EmailErrorException || e is PasswordErrorException || e is NameErrorException || e is FirstNameErrorException) {
            return;
          }
          String errorMessage = '';
          if (e is TimeoutException) {
            errorMessage = 'Le serveur ne répond pas. Veuillez réessayer.';
          } else if (e.toString().contains('Invalid login credentials')) {
            errorMessage = 'Email ou mot de passe incorrect.';
          } else if (e.toString().contains('Too many requests')) {
            errorMessage = 'Trop de tentatives. Réessayez plus tard.';
          } else if (e.toString().contains('User already registered')) {
            errorMessage = 'Cet email est déjà utilisé.';
          }else if (e is SocketException || e is AuthRetryableFetchException) {
            errorMessage = 'Aucune connexion Internet.';
          }
          else{
            errorMessage = 'Une erreur est survenue. Si elle persiste, veuillez contactez un administrateur';
          }
          setState(() {
            _generalErrorText = errorMessage;
          });
        },
      );
    });

    return Center(
      child:
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Card(
          margin: const EdgeInsets.all(24.0),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Image.asset(
                  'lib/assets/images/logo-nobg.png',
                  width: 96,
                  height: 96,
                ),
                const SizedBox(height: 16),
                Text(
                  'Materelia',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gestion de matériel informatique',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text("Inscription", style: Theme.of(context).textTheme.headlineMedium),
                if (_generalErrorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      _generalErrorText!,
                      style: _generalErrorText!.startsWith("Inscription réussie") ? const TextStyle(color: Colors.green, fontSize: 14) : const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 24),
                TextField(
                  controller: _nomController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person),
                    errorText: _nomErrorText,
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _prenomController,
                  decoration: InputDecoration(
                    labelText: 'Prénom',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person_2),
                    errorText: _prenomErrorText,
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedRole,
                  decoration: const InputDecoration(
                    labelText: 'Rôle',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: AppConstants.roleSimple, child: Text('Utilisateur Simple')),
                    DropdownMenuItem(value: AppConstants.roleTechnicien, child: Text('Technicien')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedRole = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                    errorText: _emailErrorText,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Confirmer le mot de passe',
                    border: const OutlineInputBorder(),
                    errorText: _confirmPasswordErrorText,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: authState.isLoading ? null : _submit,
                    child: authState.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.login),
                              const SizedBox(width: 8),
                              const Text('S\'inscrire')
                            ],
                          ),
                        
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous avez deja un compte ? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => context.go('/signin'),
                      child: Text(
                        "Se connecter",
                      ),
                    ),
                  ],
                ),
              ],
              ),
            ),
          ),
        ),
      )
    );
  }
}