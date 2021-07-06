import 'dart:io';

import 'package:fero/main.dart';
import 'package:fero/screens/casting_detail_page.dart';
import 'package:fero/services/casting_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

class PushNotificationService {
  final FirebaseMessaging _fm = FirebaseMessaging();
  // BuildContext _context;

  Future createNotification(String castingId, DateTime end) async {
    DateTime notiDate = end.subtract(Duration(days: 1));
    var modelId = (await FlutterSession().get("modelId")).toString();
  }
  
  Future init() async {
    var modelId = (await FlutterSession().get("modelId")).toString();
    _fm.subscribeToTopic(modelId);
    // dynamic token = _fm.getToken();
    if (Platform.isIOS) {
      _fm.requestNotificationPermissions(IosNotificationSettings());  
    }
    _fm.configure(
      // onBackgroundMessage: (message) async {
      //   print("onLaunch: $message");
      //   await gotoNotification(context, message);
      // },
      onMessage: (message) async {
        print("onMessage: $message");
        var context = navigatorKey.currentState.overlay.context;
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Go',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                    ),
                    onPressed: () async {
                      await gotoNotification(message);
                    },
                  ),
                ],
              );
            });
      },
      // onLaunch: (Map<String, dynamic> message) async {
      //   print("onLaunch: $message");
      //   // _navigateToItemDetail(message);
      // },
      onResume: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        await gotoNotification(message);
      },
    );

    _fm.getToken().then((token) => {
      update(token)
    });
  }

  update(String token) {
    print(token);
  }

  Future gotoNotification(Map<String, dynamic> message) async {
    String castingId = message["data"]["castingId"];
    var casting = await CastingService().getCasting(castingId);

    // Navigator.push(
    //   context,
    navigatorKey.currentState.push(
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => CastingListViewModel()),
                  ],
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return CastingDetailPage(
                        casting: casting,
                      );
                    },
                  ))),
    );
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidSetting;
  IOSInitializationSettings iosSetting;
  InitializationSettings initSetting;

  void initLocal() async {
    androidSetting = AndroidInitializationSettings('icon');
    iosSetting = IOSInitializationSettings();
    initSetting =
        InitializationSettings(android: androidSetting, iOS: iosSetting);
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: onSelect);
  }

  Future onSelect(String payLoad) async {
    if (payLoad != null) {
      print(payLoad);
    }
    dynamic casting = await CastingService().getCasting(payLoad);
    navigatorKey.currentState.push(
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => CastingListViewModel()),
                  ],
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return CastingDetailPage(
                        casting: casting,
                      );
                    },
                  ))),
    );
  }

  void showNotification(DateTime end, CastingViewModel casting) async {
    await notification(end, casting);
  }

  Future<void> notification(DateTime end, CastingViewModel casting) async {
    // var time = end.subtract(Duration(days: 1));
    var time = DateTime.now().add(Duration(seconds: 30));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            casting.id.toString(), 'channelName', 'channelDescription',
            priority: Priority.high,
            importance: Importance.max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin.schedule(
        casting.id,
        'You have a mesage',
        casting.name + ' casting will close tomorow',
        time,
        notificationDetails,
        payload: casting.id.toString());
  }
}
