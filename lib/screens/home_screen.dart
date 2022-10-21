import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    String deviceToken = await getDeviceToken();
    print("####### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFICATION #######");
    print(deviceToken);
    print("##########################################################");

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;

      Alert(
        context: context,
        type: AlertType.error,
        title: title,
        desc: description,
        buttons: [
          DialogButton(
            child: Text(
              "Cool",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  "Push notification",
                  style: TextStyle(fontSize: 40),
                )),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Firebase Mesaging",
                  style: TextStyle(fontSize: 18),
                )),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Future getDeviceToken() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessge = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessge.getToken();
    return (deviceToken == null) ? "" : deviceToken;
  }
}
