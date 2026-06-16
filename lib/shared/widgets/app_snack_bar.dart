import 'package:flutter/material.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    FeedbackType type = FeedbackType.info,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    final color = _color(type);
    final icon = _icon(type);

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color.background,
      duration: duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.foreground.withValues(alpha: 0.2)),
      ),
      content: Row(
        children: [
          Icon(icon, color: color.foreground, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      action: (actionLabel != null && onAction != null)
          ? SnackBarAction(
              label: actionLabel,
              textColor: color.foreground,
              onPressed: onAction,
            )
          : null,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static _SnackStyle _color(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return _SnackStyle(
          foreground: AppColors.success,
          background: AppColors.successContainer,
        );
      case FeedbackType.error:
        return _SnackStyle(
          foreground: AppColors.error,
          background: AppColors.errorContainer,
        );
      case FeedbackType.warning:
        return _SnackStyle(
          foreground: AppColors.warning,
          background: AppColors.warningContainer,
        );
      case FeedbackType.info:
        return _SnackStyle(
          foreground: AppColors.info,
          background: AppColors.infoContainer,
        );
    }
  }

  static IconData _icon(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return Icons.check_circle;
      case FeedbackType.error:
        return Icons.error;
      case FeedbackType.warning:
        return Icons.warning_amber_rounded;
      case FeedbackType.info:
        return Icons.info_outline;
    }
  }
}

class _SnackStyle {
  final Color foreground;
  final Color background;

  _SnackStyle({required this.foreground, required this.background});
}
