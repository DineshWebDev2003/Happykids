import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'screens/jar_screen.dart';
import 'screens/monitoring_screen.dart';
import 'screens/user_screen.dart';
import 'screens/website_screen.dart';
import 'screens/call_screen.dart';
import 'screens/whatsapp_screen.dart';
import 'screens/admin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Kids Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50), // Playful green
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light gray background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4CAF50),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await canLaunchUrl(uri)) {
        throw Exception('Could not launch $url');
      }
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Kids Management'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Logo Section
            Padding(
              padding: const EdgeInsets.all(40),
              child: Image.asset(
                'assets/images/logo_line-removebg-preview.png',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            // Grid Cards
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    _buildSquareCard(
                      context,
                      'Jar',
                      'assets/images/jar_icon.png',
                      const Color(0xFFC8E6C9), // Light green
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const JarScreen()),
                      ),
                    ),
                    _buildSquareCard(
                      context,
                      'Monitoring',
                      'assets/images/monitoring_icon.png',
                      const Color(0xFFFFCDD2), // Soft pink
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MonitoringScreen()),
                      ),
                    ),
                    _buildSquareCard(
                      context,
                      'User',
                      'assets/images/user_icon.png',
                      const Color(0xFFB2DFDB), // Soft teal
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UserScreen()),
                      ),
                    ),
                    _buildSquareCard(
                      context,
                      'Admin',
                      'assets/images/admin_icon.png',
                      const Color(0xFFFFE0B2), // Warm orange
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Circular Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCircularButton(
                    context,
                    'assets/images/website_icon.png',
                    const Color(0xFFFF8A65), // Coral
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WebsiteScreen()),
                    ),
                  ),
                  _buildCircularButton(
                    context,
                    'assets/images/call_icon.png',
                    const Color(0xFF64B5F6), // Sky blue
                    () => _launchURL('tel:+919514900070'),
                  ),
                  _buildCircularButton(
                    context,
                    'assets/images/whatsapp_icon.png',
                    const Color(0xFF81C784), // Fresh green
                    () => _launchURL('https://wa.me/918925105109'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareCard(
    BuildContext context,
    String title,
    String imagePath,
    Color backgroundColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                imagePath,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularButton(
    BuildContext context,
    String imagePath,
    Color backgroundColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}