import 'dart:developer' as developer;
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class BackgroundLocationService {
  static void initService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'ride_together_location',
        channelName: 'Live Group Location Sharing',
        channelDescription:
            'Displays persistent notification while sharing location with your group in the background.',
        channelImportance: NotificationChannelImportance.DEFAULT,
        priority: NotificationPriority.DEFAULT,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: false,
      ),
    );
  }

  static Future<ServiceRequestResult> startService() async {
    final permission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (permission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        serviceId: 200,
        notificationTitle: 'RideTogether — Group Ride Active',
        notificationText:
            'Sharing live location with your group in the background',
        notificationButtons: [
          const NotificationButton(
            id: 'stop_sharing',
            text: 'Stop Sharing',
          ),
        ],
        callback: _taskCallback,
      );
    }
  }

  static Future<ServiceRequestResult> stopService() async {
    developer.log('🛑 [BackgroundLocation] Stopping foreground service...', name: 'Location');
    return FlutterForegroundTask.stopService();
  }
}

@pragma('vm:entry-point')
void _taskCallback() {
  FlutterForegroundTask.setTaskHandler(_LocationTaskHandler());
}

class _LocationTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    developer.log('🚀 [BackgroundLocation] TaskHandler started', name: 'Location');
  }

  @override
  Future<void> onRepeatEvent(DateTime timestamp) async {
    // Repeated background task heartbeat
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    developer.log('🛑 [BackgroundLocation] TaskHandler destroyed', name: 'Location');
  }

  @override
  void onNotificationButtonPressed(String id) {
    if (id == 'stop_sharing') {
      developer.log('🛑 [BackgroundLocation] User tapped "Stop Sharing" in system notification!', name: 'Location');
      FlutterForegroundTask.stopService();
    }
  }

  @override
  void onNotificationDismissed() {
    developer.log('🔔 [BackgroundLocation] Notification dismissed', name: 'Location');
  }
}
