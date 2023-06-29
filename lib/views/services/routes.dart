import 'package:flutter/material.dart';
import 'package:healthcare/views/profile%20screen/editprofile.dart';
import '../HomePage.dart';

class RouteGenerator {
  static const String main = '/HomePage';
  static const String login = '/Login';
  static const String edit = '/editprofile';

  RouteGenerator._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(
          builder: (_) => HomePage(
            Age: '',
            Username: '',
            Gender: '',
          ),
        );
      case edit:
        return MaterialPageRoute(
          builder: (_) => const editProfile(),
        );
           case login:
       
      default:
        throw const RouteException('Route not found');
    }
  }
}

class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}
