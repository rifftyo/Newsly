import 'package:flutter/material.dart';
import 'package:news_app/services/auth_service.dart';
import 'package:news_app/ui/sign/login_page.dart';

class ProfilePage extends StatelessWidget {
  final _authService = AuthService();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: TextButton(
                onPressed: () async {
                  await _authService.signOut();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  }
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
