import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;
  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  AuthProvider() {
    _user = supabase.auth.currentUser;
  }

  // Corrected signUp
  Future<void> signUp(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      _user = response.user;
      notifyListeners();
      Fluttertoast.showToast(msg: "Sign Up Success!");
    } catch (e) {
      Fluttertoast.showToast(msg: "Sign Up Error: $e");
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _user = response.user;
      notifyListeners();
      Fluttertoast.showToast(msg: "Signed In!");
    } catch (e) {
      Fluttertoast.showToast(msg: "Sign In Error: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      _user = null;
      notifyListeners();
      Fluttertoast.showToast(msg: "Signed Out!");
    } catch (e) {
      Fluttertoast.showToast(msg: "Sign Out Error: $e");
    }
  }
}
