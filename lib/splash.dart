import 'dart:async';
import 'package:btech_app/screen-0/login/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: const Login(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Splash.png'),
            const SizedBox(
              height: 30,
            ),
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 26, 2, 240),
              backgroundColor: Color.fromARGB(255, 223, 6, 6),
              strokeWidth: 5,
            )
          ],
        ),
      ),
    );
  }
}
