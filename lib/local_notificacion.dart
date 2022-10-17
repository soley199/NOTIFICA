import 'dart:ffi';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class Noticacions{
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

init(){
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("America/Mexico_City"));
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("ic_launcher");

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    );

    this.flutterLocalNotificationsPlugin.initialize(initializationSettings);

}
 Future<void> showNotification(String tittle) async{
  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    "your chanel ", 
    "channel name",
    priority: Priority.max,
    importance: Importance.max,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      );

      await this.flutterLocalNotificationsPlugin.show(
        0,
        tittle,
        "Inside the Notificacion",
        notificationDetails);
 }

 Future<void> scheduleweeklyNotificacion() async{

  final details = NotificationDetails(
    android: AndroidNotificationDetails(
      "id",
      "name",
      priority: Priority.max,
      importance: Importance.max,
    ),
  );


  await this.flutterLocalNotificationsPlugin.zonedSchedule(
    1,
    "Notificacion Mañana",
    "body",
    _netxsinstanceryday(),
    details,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
 }
 
  tz.TZDateTime _netxsinstanceryday() {
    tz.TZDateTime scheduleDate = _nextInstanceOfTenAM();
    while(scheduleDate.weekday!= DateTime.friday){
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }
  
  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, now.year, now.month,now.day,10,50);
    if(scheduleDate.isBefore(now)){
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }
}