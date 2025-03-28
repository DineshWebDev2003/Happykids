import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class JarScreen extends StatelessWidget {
  const JarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/images/coming-soon.json',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
} 