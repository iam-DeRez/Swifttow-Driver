import 'package:google_maps_flutter/google_maps_flutter.dart';

class TowDetails {
  String? pickUpAddress;
  String? dropOffAddress;
  LatLng? pickup;
  LatLng? dropOff;
  String? towRequestID;
  String? towUserName;
  String? towUserNumber;
  String? paymentMethod;
  String? towingFare;

  TowDetails({
    this.pickUpAddress,
    this.dropOffAddress,
    this.pickup,
    this.dropOff,
    this.towRequestID,
    this.towUserName,
    this.towUserNumber,
  });
}
