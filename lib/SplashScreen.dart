import 'dart:async';

import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));     
    } );}

    @override
        void initState() {
          super.initState();
          startSplashScreen();
        }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("images/Vector 2.jpg", 
            height: 679,
            width: 412,
            fit: BoxFit.contain,),
          ),
          Text("Welcome"),
          Text("Memantau peserta magang dengan mobilitas tinggi menjadi lebih mudah dengan aplikasi manajemen informasi peserta magang berbasis mobile.")
        ],
      ),
    );
  }
}