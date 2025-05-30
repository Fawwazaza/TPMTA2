import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthService with ChangeNotifier {
  bool _isLoggedIn = false;
  String _username = '';

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  Future<bool> login(String username, String password) async {
    // Password "admin123" yang sudah di-hash
    if (username == "admin" && _hashPassword(password) == 
        "240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9") {
      _isLoggedIn = true;
      _username = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isLoggedIn = false;
    _username = '';
    notifyListeners();
  }
}