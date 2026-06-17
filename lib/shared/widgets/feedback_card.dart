import 'package:flutter/material.dart';
import 'package:materelia/core/theme/app_colors.dart';

enum FeedbackType { success, error, warning, info }

class FeedbackCard extends StatelessWidget {
  final FeedbackType type;
  final IconData? icon;

  final String message;
  final String? title;

  final Widget? action;

  final EdgeInsetsGeometry padding;
  final bool dense;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? messageColor;

  const FeedbackCard({
    super.key,
    required this.type,
    required this.message,
    this.title,
    this.action,
    this.padding = const EdgeInsets.all(16),
    this.dense = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.messageColor,
  });

  Color get _background {
    switch (type) {
      case FeedbackType.success:
        return AppColors.successContainer;

      case FeedbackType.error:
        return AppColors.errorContainer;

      case FeedbackType.warning:
        return AppColors.warningContainer;

      case FeedbackType.info:
        return AppColors.infoContainer;
    }
  }

  Color get _foreground {
    switch (type) {
      case FeedbackType.success:
        return AppColors.success;

      case FeedbackType.error:
        return AppColors.error;

      case FeedbackType.warning:
        return AppColors.warning;

      case FeedbackType.info:
        return AppColors.info;
    }
  }

  IconData get _icon {
    switch (type) {
      case FeedbackType.success:
        return Icons.check_circle;

      case FeedbackType.error:
        return Icons.error;

      case FeedbackType.warning:
        return Icons.warning;

      case FeedbackType.info:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? _background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (foregroundColor ?? _foreground).withValues(alpha: .20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon ?? _icon,
            color: foregroundColor ?? _foreground,
            size: dense ? 20 : 24,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: foregroundColor ?? _foreground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                if (title != null) const SizedBox(height: 4),

                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: messageColor ?? AppColors.textPrimary,
                  ),
                ),

                if (action != null) ...[const SizedBox(height: 12), action!],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
