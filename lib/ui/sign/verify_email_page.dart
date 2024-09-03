import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/main/home_page.dart';
import 'package:news_app/services/auth_service.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final AuthService _authService = AuthService();
  User? user;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

    // Mulai memeriksa status verifikasi email secara berkala
    timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      bool isVerified = await _authService.isEmailVerified(user!);
      if (isVerified && mounted) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Verifikasi Email Anda',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Kami telah mengirimkan link verifikasi ke email Anda.\nSilakan cek inbox Anda.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
