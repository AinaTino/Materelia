// lib/shared/widgets/loading.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}