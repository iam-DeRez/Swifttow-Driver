import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swifttowdriver/Screens/signup.dart';

import 'login.dart';
import '../modules/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              //Image
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/p1.png"), fit: BoxFit.fill)),
              ),

              const SizedBox(
                height: 50,
              ),

              //logo and heading
              const Padding(
                padding: EdgeInsets.only(left: 70, right: 70),
                child: Text(
                  "Welcome 👋 to Swift Tow Driver",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //description text
              const Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  "According to Swift Tow 2:4, A good driver is always a helper!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.3,
                      color: subtext),
                ),
              ),

              const SizedBox(
                height: 90,
              ),

              //Login button
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            childCurrent: this,
                            alignment: Alignment.bottomCenter,
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 600),
                            reverseDuration: const Duration(milliseconds: 600),
                            child: const SignUp()));
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
                    "Start Driving",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              //Create account button
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            childCurrent: this,
                            alignment: Alignment.bottomCenter,
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 600),
                            reverseDuration: const Duration(milliseconds: 600),
                            child: const Login()));
                  },
                  style: TextButton.styleFrom(foregroundColor: text),
                  child: const Text("Already having an account? Login"))
            ],
          ),
        ),
      ),
    );
  }
}
