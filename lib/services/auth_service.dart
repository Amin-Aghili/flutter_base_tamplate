import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_template/main.dart';
import 'package:flutter_base_template/models/auth_model.dart';
import 'package:flutter_base_template/screens/auth/login_or_register_screen.dart';
import 'dio_client.dart';
import 'local_storage_service.dart';
import 'session_manager.dart';

class AuthService with ChangeNotifier {
  final session = SessionManager();
  final LocalStorageService storage = LocalStorageService();
  // // Uncomment the following lines to enable actual API calls
  // final _dio = Dio(
  //   BaseOptions(
  //     baseUrl: 'https://api.example.com', // paste your API base URL here
  //   ),
  // );
  // int _refreshAttempts = 0;

  // Future<bool> refreshToken() async {
  //   // remove for develop
  //   String? token = storage.getStr('token');
  //   if (token != null) {
  //     DioClient().setToken(token);
  //     return true;
  //   }
  //   // ----------
  //   _refreshAttempts++;
  //   if (session.token == null || session.token!.isEmpty) {
  //     await logout();
  //     _refreshAttempts = 0;
  //     return false;
  //   }
  //   try {
  //     if (session.username != null && session.password != null) {
  //       final isValid = await login(session.username!, session.password!);
  //       if (!isValid || _refreshAttempts > 2) {
  //         await logout();
  //         _refreshAttempts = 0;
  //       }
  //       return isValid;
  //     } else {
  //       return false;
  //     }
  //   } catch (_) {
  //     return false;
  //   }
  // }

  Future<bool> login(String username, String password) async {
    if (username.isNotEmpty || password.isNotEmpty) {
      await Future.delayed(const Duration(seconds: 2));
      return true;
    }
    return false; // Simulate successful login for development
    // // Uncomment the following code to enable actual login functionality
    // try {
    //   final response = await _dio.post(
    //     '/Auth/ShopUserLogin',
    //     data: {
    //       'username': username,
    //       'password': password,
    //     },
    //   );

    //   if (response.statusCode == 200 && response.data != null) {
    //     final auth = AuthModel.fromJson(jsonDecode(response.data));

    //     session.setLoginData(
    //       username,
    //       password,
    //       auth.token,
    //     );
    //     await storage.saveData('userId', auth.userId);
    //     await storage.saveData('shopId', auth.shopId);
    //     await storage.saveUsername(username);
    //     // Remove this for develop
    //     await storage.saveData('token', auth.token);
    //     // -------
    //     DioClient().setToken(auth.token);

    //     notifyListeners();
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } catch (e) {
    //   debugPrint('Error during login: $e');
    //   return false;
    // }
  }

  Future<void> logout() async {
    session.clear();
    await storage.clear();
    DioClient().clearToken();

    await navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginOrRegisterScreen()),
      (route) => false,
    );

    notifyListeners();
  }
}
