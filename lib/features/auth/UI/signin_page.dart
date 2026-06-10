import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/core/router/app_router.dart';
import 'package:materelia/features/auth/service/auth_exception.dart';
import 'package:materelia/features/auth/provider/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;
  String? _emailErrorText;
  String? _passwordErrorText;
  String? _generalErrorText;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _emailErrorText = null;
      _passwordErrorText = null;
      _generalErrorText = null;
    });

    final authNotifier = ref.read(authControllerProvider.notifier);
    await authNotifier.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    final state = ref.read(authControllerProvider);
    if (state.hasError) {
      final error = state.error;
      if (error is AuthFieldException) {
        setState(() {
          switch (error) {
            case EmailErrorException():    _emailErrorText = error.message;
            case PasswordErrorException(): _passwordErrorText = error.message;
            default: break;
          }
        });
      }
    }
    else {
      rootRouter.go("/callback");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    // Écoute les erreurs et redirige en cas de succès
    ref.listen(authControllerProvider, (_, next) {
      next.whenOrNull(
        data: (_) => context.go('/callback'),
        error: (e, _) {
          if (e is EmailErrorException || e is PasswordErrorException) {
            return;
          }
          String errorMessage = '';
          if (e is TimeoutException) {
            errorMessage = 'Le serveur ne répond pas. Veuillez réessayer.';
          } else if (e.toString().contains('Email not confirmed')) {
            errorMessage = 'Veuillez confirmer votre email.';
          }else if (e.toString().contains('Invalid login credentials')) {
            errorMessage = 'Email ou mot de passe incorrect.';
          } else if (e.toString().contains('Email not confirmed')) {
            errorMessage = 'Veuillez confirmer votre email.';
          } else if (e.toString().contains('Too many requests')) {
            errorMessage = 'Trop de tentatives. Réessayez plus tard.';
          } else if (e is SocketException || e is AuthRetryableFetchException) {
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
        constraints: const BoxConstraints(maxWidth: 500),
        child: Card(
          margin: const EdgeInsets.all(24.0),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
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
                Text("Se connecter", style: Theme.of(context).textTheme.headlineMedium),
                if (_generalErrorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      _generalErrorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 24),
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
                    errorText: _passwordErrorText,
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
                              const Text('Se connecter')
                            ],
                          ),
                        
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pas de compte ? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => context.go('/signup'),
                      child: const Text("Cliquez ici pour s'inscrire"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}