import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class TopBar extends ConsumerWidget {
  final String title;
  const TopBar({super.key,required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      centerTitle: true,
      title: Text('${MediaQuery.of(context).size.width < 800?'':'Materelia -'} $title'),

      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await SupabaseService.client.auth.signOut();
          },
        ),
      ],
    );
  }
}