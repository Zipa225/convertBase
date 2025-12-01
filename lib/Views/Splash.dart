import 'dart:async';
import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();


    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: Image.asset(
                  "assets/images/icConvert.PNG",
                  width: 150,
                  height: 150,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Bienvenue sur ConvertBase",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF021024),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "Développé par Emmanuel Ble",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "member of",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Ottaku-dev",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF7DA0C4),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
