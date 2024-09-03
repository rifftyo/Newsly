import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/auth_service.dart';

class AuthProviderSign extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<User?> signUp(String email, String password) async {
    _setLoading(true);
    User? user =
        await _authService.registerWithEmailAndPassword(email, password);
    _setLoading(false);
    return user;
  }

  Future<User?> signIn(String email, String password) async {
    _setLoading(true);
    User? user = await _authService.signInWithEmailAndPassword(email, password);
    _setLoading(false);
    return user;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
