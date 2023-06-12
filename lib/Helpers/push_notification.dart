import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:swifttowdriver/DataModels/towRequestDetails.dart';
import '../modules/TowRequestPopUp.dart';
import '../modules/global_variable.dart';

class PushNotification {
  final FirebaseMessaging fcm = FirebaseMessaging.instance;

  String? requestID;
  Future initialize(context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');
      // Handle incoming ride request here
      if (message.data.isNotEmpty) {
        // Access request ID
        requestID = message.data['requestID'];
        print("RequestID: $requestID");
        retrievingTowRequest(context);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onResume: $message');
      // Handle resuming the app from background
      if (message.data.isNotEmpty) {
        // Access request ID
        requestID = message.data['requestID'];
        print("RequestID: $requestID");
        retrievingTowRequest(context);
      }
    });
  }

  Future<String> getToken() async {
    final user = FirebaseAuth.instance.currentUser!;

    String? token = await fcm.getToken();
    print("Token: $token");

    DatabaseReference tokenRef =
        FirebaseDatabase.instance.ref().child('drivers/${user.uid}/token');
    tokenRef.set(token);

    fcm.subscribeToTopic('all drivers');

    return token!;
  }

  Future<void> retrievingTowRequest(context) async {
    print('Audio played successfully');
    final userRef = FirebaseDatabase.instance.ref();

    //Retrieving tow request data
    DatabaseEvent event = await userRef.child("TowRequest/$requestID").once();
    dynamic requestData = event.snapshot.value;

    //pickup location
    double pickUpLat = double.parse(requestData['Location']['Latitude']);
    double pickUpLong = double.parse(requestData['Location']['Latitude']);
    String currentAddress = requestData['Pickup_address'].toString();

    //dropOffLocation
    double dropOffLat = double.parse(requestData['Destination']['Latitude']);
    double dropOffLong = double.parse(requestData['Destination']['Latitude']);
    String destination = requestData['DropOff_address'].toString();

//passing data to the request dialog screen
    TowRequestDialogState.pickUpAddress = currentAddress;
    TowRequestDialogState.dropOffAddress = destination;

//play audio when request is received

    await audioPlayer.setAsset('audios/alert.mp3');
    audioPlayer.play();
    audioPlayer.setLoopMode(LoopMode.one);

    //UserRequestDetails
    String userName = requestData['Name'].toString();
    String userPhone = requestData['Phone'].toString();
    String payment = requestData['Payment'].toString();
    String towFare = requestData['Fare'].toString();

    //Creating data model for each request Details
    TowDetails towDetails = TowDetails();
    towDetails.pickUpAddress = currentAddress;
    towDetails.dropOffAddress = destination;
    towDetails.pickup = LatLng(pickUpLat, pickUpLong);
    towDetails.dropOff = LatLng(dropOffLat, dropOffLong);
    towDetails.towUserName = userName;
    towDetails.towUserNumber = userPhone;
    towDetails.paymentMethod = payment;
    towDetails.towingFare = towFare;

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: false,
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const TowRequestDialog();
        });
  }
}
