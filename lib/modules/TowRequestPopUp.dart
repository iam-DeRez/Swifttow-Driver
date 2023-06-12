import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:swifttowdriver/DataModels/towRequestDetails.dart';
import 'package:swifttowdriver/Helpers/push_notification.dart';

import 'package:swifttowdriver/modules/colors.dart';
import 'package:swifttowdriver/modules/global_variable.dart';

class TowRequestDialog extends StatefulWidget {
  const TowRequestDialog({super.key});

  @override
  State<TowRequestDialog> createState() => TowRequestDialogState();
}

class TowRequestDialogState extends State<TowRequestDialog> {
  static String? pickUpAddress;
  static String? dropOffAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: MediaQuery.of(context).size.height * 0.53,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.5),
                    topRight: Radius.circular(25.5)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(66, 88, 88, 88),
                    blurRadius: 25.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  )
                ]),
            child: Column(children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              Column(
                children: [
                  const Text(
                    "New Tow Request",
                    style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.asset(
                      'images/cash.png',
                      scale: 4,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text("GHc 22.00",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            letterSpacing: 0.5,
                            color: subtext)),
                  ]),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(
                    thickness: 1.5,
                    color: background,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              //container
              Container(
                padding: const EdgeInsets.only(
                    top: 20, right: 29, left: 29, bottom: 20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: gray100,
                ),
                child: Column(
                  children: [
                    //pickup location
                    Row(
                      children: [
                        Image.asset(
                          "images/location.png",
                          scale: 3.5,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          pickUpAddress!,
                          style: const TextStyle(color: subtext),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 27,
                    ),

                    //dropOff location
                    Row(
                      children: [
                        Image.asset(
                          "images/dropOff.png",
                          scale: 3.5,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(dropOffAddress!,
                            style: const TextStyle(color: subtext))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 38,
              ),
              //button
              Container(
                  child: Column(children: [
                ElevatedButton(
                  onPressed: () {
                    audioPlayer.stop();
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    backgroundColor: MaterialStateProperty.all(green),
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 55)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Accept Request",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    audioPlayer.stop();
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 55)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1.2,
                          color: border,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Decline",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.black),
                    ),
                  ),
                ),
              ])),
            ]))
        .animate()
        .fade(duration: const Duration(milliseconds: 700))
        .slide(
            begin: const Offset(0, 100),
            duration: const Duration(milliseconds: 600),
            curve: Curves.fastLinearToSlowEaseIn);
  }
}
