import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_svg/svg.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:swifttowdriver/Helpers/push_notification.dart';

import '../modules/colors.dart';
import '../modules/global_variable.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  //google maps controller
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

//maps contoller
  GoogleMapController? mapController;

//current user details
  final user = FirebaseAuth.instance.currentUser!;

//database reference for trip request
  DatabaseReference? tripRequestRef;

  //Locations
  Position? currentPosition;
  static String currentAddress = "";
  static LatLng? latlngPosition;

  bool _isClicked = false;

  //Current Location
  Future locatePosition() async {
    await Geolocator.checkPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    latlngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latlngPosition!, zoom: 17);

    mapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    //Database initiation
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference driversLocation =
        FirebaseDatabase.instance.ref().child('drivers/${user.uid}/Location');
    await driversLocation.child(user.uid).set({
      'Latitude': latlngPosition!.latitude,
      'Longitude': latlngPosition!.longitude,
    });

    // List<Placemark> placemarks =
    //     await placemarkFromCoordinates(position.latitude, position.longitude);
    // String locality = placemarks[0].locality!;
    // String subThoroughfare = placemarks[1].administrativeArea!;
    // setState(() {
    //   currentAddress = "$locality, $subThoroughfare";
    // });
  }

//Driver go online
  void goOnline() {
    Geofire.initialize('driversAvailable');
    if (_isClicked) {}

    tripRequestRef = FirebaseDatabase.instance
        .ref()
        .child("drivers/${user.uid}/newTowRequest");
    tripRequestRef!.set('waiting');

    tripRequestRef!.onValue.listen((event) {});
    getCurrentDriverDetailsForNotification();
  }

// Driver go offline
  void goOffline() {
    Geofire.removeLocation(user.uid);
    tripRequestRef!.onDisconnect();
    tripRequestRef!.remove();
    tripRequestRef = null;
  }

//Get driver location updates
  void getLocationLiveUpdates() {
    homeTabPositionStream =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;

      if (_isClicked) {
        Geofire.setLocation(
            user.uid, latlngPosition!.latitude, latlngPosition!.longitude);
      }

      latlngPosition = LatLng(position.latitude, position.longitude);

      mapController!.animateCamera(CameraUpdate.newLatLng(latlngPosition!));
    });
  }

//get drivers details for notification
  void getCurrentDriverDetailsForNotification() {
    PushNotification pushNotification = PushNotification();

    pushNotification.initialize(context);
    pushNotification.getToken();
  }

  // textcontroller
  var actualLocation = TextEditingController();
  var dropOfflocation = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    locatePosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          //maps
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: const CameraPosition(
                target: LatLng(5.614818, -0.205874), zoom: 10),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;
              locatePosition();
            },
          ),

          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(66, 88, 88, 88),
                  blurRadius: 25.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                )
              ]),
              padding: const EdgeInsets.all(30),
              child: ElevatedButton.icon(
                label: _isClicked
                    ? const Text("Go Offline")
                    : const Text("Go Online"),
                icon: _isClicked
                    ? SvgPicture.asset("images/offline.svg")
                    : SvgPicture.asset("images/online.svg"),
                onPressed: () {
                  setState(() {
                    _isClicked = !_isClicked;
                    if (_isClicked) {
                      goOnline();
                      getLocationLiveUpdates();
                    } else {
                      goOffline();
                    } // Toggle the state
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 52),
                  backgroundColor: _isClicked ? green : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
