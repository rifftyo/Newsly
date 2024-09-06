import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Pendaftaran Pengguna
  Future<User?> registerWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // Kirim email verifikasi
      await user?.sendEmailVerification();

      // Simpan data ke firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
        saveLoginStatus();
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login Pengguna
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null && user.emailVerified) {
        saveLoginStatus();
        return user;
      } else {
        print("Email belum diverifikasi");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Logout Pengguna
  Future signOut() async {
    try {
      await _auth.signOut();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('isLoggedIn', false);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Memeriksa Status Email Verifikasi
  Future<bool> isEmailVerified(User user) async {
    await user.reload();
    User? updatedUser = _auth.currentUser;

    return updatedUser != null && updatedUser.emailVerified;
  }

  // Menyimpan Status Login
  Future<void> saveLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLoggedIn', true);
  }

  Future<String?> getUsername(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(uid).get();

      if (documentSnapshot.exists) {
        return documentSnapshot['username'];
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
