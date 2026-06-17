// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// enum FeedbackType {
//   error,
//   info,
//   notify,
//   remove,
//   success,
// }

// class FeedbackEvent {
//   final FeedbackType type;
//   final String? title;
//   final String? message;

//   const FeedbackEvent({
//     required this.type,
//     this.title,
//     this.message,
//   });
// }

// class FeedbackService {
//   FeedbackService._();

//   static final instance = FeedbackService._();

//   final FlutterLocalNotificationsPlugin _notifications =
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     const windows = WindowsInitializationSettings(
//       appName: 'MateRelia',
//       appUserModelId: 'com.materelia.app',
//       guid: 'com.materelia.app',
//     );

//     const settings = InitializationSettings(
//       windows: windows,
//     );

//     await _notifications.initialize(settings);
//   }

//   Future<void> play(FeedbackEvent event) async {
//     final title = event.title ?? _defaultTitle(event.type);
//     final body = event.message ?? _defaultMessage(event.type);

//     if (Platform.isWindows) {
//       await _showNotification(title, body);
//       return;
//     }

//     if (Platform.isAndroid) {
//       _haptic(event.type);
//     }
//   }

//   Future<void> _showNotification(String title, String body) async {
//     const details = NotificationDetails(
//       windows: WindowsNotificationDetails(),
//     );

//     await _notifications.show(0, title, body, details);
//   }

//   void _haptic(FeedbackType type) {
//     switch (type) {
//       case FeedbackType.success:
//         HapticFeedback.lightImpact();
//         break;
//       case FeedbackType.error:
//         HapticFeedback.heavyImpact();
//         break;
//       default:
//         HapticFeedback.selectionClick();
//     }
//   }

//   String _defaultTitle(FeedbackType type) {
//     switch (type) {
//       case FeedbackType.success:
//         return "Succès";
//       case FeedbackType.error:
//         return "Erreur";
//       case FeedbackType.notify:
//         return "Notification";
//       case FeedbackType.remove:
//         return "Suppression";
//       case FeedbackType.info:
//         return "Info";
//     }
//   }

//   String _defaultMessage(FeedbackType type) {
//     switch (type) {
//       case FeedbackType.success:
//         return "Opération réussie";
//       case FeedbackType.error:
//         return "Une erreur est survenue";
//       case FeedbackType.notify:
//         return "Nouvelle notification";
//       case FeedbackType.remove:
//         return "Élément supprimé";
//       case FeedbackType.info:
//         return "Information";
//     }
//   }
// }