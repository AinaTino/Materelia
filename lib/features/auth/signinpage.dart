import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/features/auth/authprovider.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState =
        ref.watch(authControllerProvider);

    ref.listen(authControllerProvider,
      (_, next) {
        next.whenOrNull(
          data: (_) {
            context.go('/utilisateur');
          },
          error: (e, _) {
            ScaffoldMessenger.of(context)
              .showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
          },
        );
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: emailController,
            ),

            TextField(
              controller: passwordController,
              obscureText: true,
            ),

            ElevatedButton(
              onPressed: authState.isLoading
                  ? null
                  : () {
                      ref
                          .read(
                            authControllerProvider
                                .notifier,
                          )
                          .signIn(
                            email:
                                emailController.text,
                            password:
                                passwordController.text,
                          );
                    },
              child: authState.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}