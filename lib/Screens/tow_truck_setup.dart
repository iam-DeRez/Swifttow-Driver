import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swifttowdriver/Screens/home.dart';

import '../modules/colors.dart';

class truckDetails extends StatefulWidget {
  const truckDetails({super.key});

  @override
  State<truckDetails> createState() => _truckDetailsState();
}

class _truckDetailsState extends State<truckDetails> {
  final formsfield = GlobalKey<FormState>();

  final user = FirebaseAuth.instance.currentUser!;

  //Controllers
  var truckColor = TextEditingController();
  var truckModel = TextEditingController();
  var driversLicense = TextEditingController();
  var licensePlate = TextEditingController();

  //save drivers data
  void storingTruckDetails() async {
    //instantiate database

    String uid = user.uid;
    DatabaseReference newDriverRef =
        FirebaseDatabase.instance.ref().child('drivers/$uid/tow_truck_details');

//push user details to database
    await newDriverRef.child(uid).set({
      'Tow truck color': truckColor.text,
      'truck model': truckModel.text,
      'drivers license': driversLicense.text,
      'license number': licensePlate.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: formsfield,
            child: ListView(
              children: [
                const SizedBox(
                  height: 45,
                ),
                //heading and sub heading
                const Text(
                  "Tow Truck Details",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                const SizedBox(
                  height: 8,
                ),

                const Text(
                  "We can see you are new here! Register and enjoy our services with ease.",
                  style: TextStyle(color: subtext, height: 1.25),
                ),

                const SizedBox(
                  height: 35,
                ),

                // Email Textfield
                const Text(
                  "Tow Truck Color",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),

                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: truckColor,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 179, 54, 54),
                    )),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 204, 61, 61),
                    )),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: primary),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    hintText: 'Yellow',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 12.0),
                  ),

                  //Validating textfield
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter truck color';
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 35,
                ),

                //Tow truck Textfield
                const Text(
                  "Tow Truck Model",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),

                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: truckModel,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 179, 54, 54),
                    )),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 204, 61, 61),
                    )),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: primary,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Eg. Hyundai Mighty',
                    hintStyle: const TextStyle(fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 12.0),
                  ),

                  //validating textfield
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter tow truck model';
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 35,
                ),

                //Drivers License Textfield
                const Text(
                  "Drivers License",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),

                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: driversLicense,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 179, 54, 54),
                    )),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 204, 61, 61),
                    )),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: primary,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Eg. 36885676623',
                    hintStyle: const TextStyle(fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 12.0),
                  ),

                  //validating textfield
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Drivers License';
                    }

                    if (value.length < 10) {
                      return 'Should be up to 11 digits';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 35,
                ),

                //License Plate Textfield
                const Text(
                  "License Plate",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: licensePlate,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 179, 54, 54),
                    )),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 204, 61, 61),
                    )),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: primary,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Eg. GC 717 23',
                    hintStyle: const TextStyle(fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 12.0),
                  ),

                  //validating Email
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter license plate number';
                    }

                    if (value.length < 10) {
                      return 'Should be up to 10 digits';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 35,
                ),

                const SizedBox(
                  height: 55,
                ),

                //Login button
                ElevatedButton(
                  onPressed: () {
                    storingTruckDetails();
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            childCurrent: widget,
                            alignment: Alignment.bottomCenter,
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 600),
                            reverseDuration: const Duration(milliseconds: 600),
                            child: const Home()));
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(300, 52)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Procced",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
