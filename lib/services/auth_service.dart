import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Pendaftaran Pengguna
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // Kirim email verifikasi
      await user?.sendEmailVerification();
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
      return await _auth.signOut();
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
}
