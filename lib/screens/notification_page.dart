import 'package:fero/services/push_notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidSetting;
  IOSInitializationSettings iosSetting;
  InitializationSettings initSetting;

  @override
  void initState() {
    super.initState();
    init();
    PushNotificationService().init();
  }

  void init() async {
    androidSetting = AndroidInitializationSettings('icon');
    iosSetting = IOSInitializationSettings();
    initSetting =
        InitializationSettings(android: androidSetting, iOS: iosSetting);
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: onSelect);
  }

  void _showNotification() async {
    await notification();
  }

  Future<void> notification() async {
    var time = DateTime.now().add(Duration(seconds: 5));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'channelId', 'channelName', 'channelDescription',
            priority: Priority.high,
            importance: Importance.max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin.schedule(
        1, 'Hello', 'body', time ,notificationDetails);
  }

  Future onSelect(String payLoad) async {
    if (payLoad != null) {
      print(payLoad);
    }

    //sang trang khac
  }

  Future onDidReceivedLocalNotification(
      int id, String title, String body, String payLoad) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            print('ok');
          },
          child: Text('Ok'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notification'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  FlatButton(onPressed: _showNotification, child: Text('Tap'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
