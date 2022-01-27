import 'package:flutter/material.dart';
import 'package:map/constants/route_strings.dart';
import 'package:map/persentation/screens/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      
    }
  }

}