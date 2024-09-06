import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/auth_provider_sign.dart';
import 'package:news_app/ui/sign/login_page.dart';
import 'package:news_app/ui/sign/verify_email_page.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool isSeen = false;

  void changeVisibility() {
    setState(() {
      isSeen = !isSeen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProviderSign(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<AuthProviderSign>(
            builder: (context, authProvider, _) {
              return Stack(
                children: [
                  Column(
                    children: [
                      const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 45,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                          child: Image.asset('assets/news_icon.png',
                              width: 100, height: 100)),
                      const SizedBox(height: 50),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Type your username",
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Type your email",
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          obscureText: isSeen ? false : true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: changeVisibility,
                                icon: isSeen
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Type your password",
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: authProvider.isLoading
                                ? null
                                : () async {
                                    String email = _emailController.text.trim();
                                    String password =
                                        _passwordController.text.trim();
                                    String username =
                                        _usernameController.text.trim();

                                    User? user = await authProvider.signUp(
                                        email, password, username);

                                    if (user != null && context.mounted) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const VerifyEmailPage()));
                                    } else if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Pendaftaran gagal, coba lagi.'),
                                            backgroundColor: Colors.red),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an account?  ',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (authProvider.isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
