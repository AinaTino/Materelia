import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  try {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  } catch (e) {
    runApp(
      ProviderScope(
        child: MaterialApp(home: Scaffold(body: Text("Aucune connexion internet"))),
      ),
    );
    return;
  }

  runApp(
    const ProviderScope(
      child: MateReliaApp(),
    ),
  );
}

class MateReliaApp extends StatelessWidget {
  const MateReliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MateRelia',
      theme: AppTheme.light,
      routerConfig: rootRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}