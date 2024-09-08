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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  Form(
                    key: _formKey,
                    child: Column(
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
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Type your username",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Username harus diisi';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Type your email",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email harus diisi';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return 'Format email tidak valid';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
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
                            validator: (value) {
                              // Memeriksa apakah password diisi atau tidak
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              // Memeriksa apakah panjang password kurang dari 8 karakter
                              if (value.length < 8) {
                                return 'Password minimal harus 8 karakter';
                              }
                              // Memeriksa apakah password mengandung huruf kapital
                              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return 'Password harus mengandung setidaknya 1 huruf kapital';
                              }
                              // Memeriksa apakah password mengandung angka
                              if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Password harus mengandung setidaknya 1 angka';
                              }
                              return null; // Jika semua validasi lolos
                            },
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
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        String email =
                                            _emailController.text.trim();
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
                                        builder: (context) =>
                                            const LoginPage()));
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
