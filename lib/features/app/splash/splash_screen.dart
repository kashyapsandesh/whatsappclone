import 'dart:async';
import 'package:flutter/material.dart';
import 'package:whatsappclone/features/app/const/app_const.dart';
import 'package:whatsappclone/features/app/theme/style.dart';
import 'package:whatsappclone/features/app/welcome/welcome_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const WelcomePage(),
        ),
            (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Image.asset("assets/whats_app_logo.png", color: Colors.white, width: 100, height: 100,),
            Column(
              children: [
                Text("from", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: greyColor.withOpacity(.6)),),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/meta.png", color: Colors.white, width: 35, height: 35,),
                    const SizedBox(width: 5,),
                    const Text("Meta", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
                  ],
                ),
                const SizedBox(height: 30,),
              ],
            )
          ],
        )
    );
  }
}