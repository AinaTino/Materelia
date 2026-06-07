
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class AuthNotifier extends ChangeNotifier {
  late final StreamSubscription _subscription;

  AuthNotifier() {
    _subscription = SupabaseService.authStateStream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}