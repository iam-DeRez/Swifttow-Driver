import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  final FirebaseMessaging fcm = FirebaseMessaging.instance;

  Future initialize() async {}

  Future<String> getToken() async {
    final user = FirebaseAuth.instance.currentUser!;

    String? token = await fcm.getToken();
    print("Token: $token");

    DatabaseReference tokenRef =
        FirebaseDatabase.instance.ref().child('drivers/${user.uid}/token');
    tokenRef.set(token);

    fcm.subscribeToTopic('all drivers');
    fcm.subscribeToTopic('all users');

    return token!;
  }
}
