import 'package:flutter/material.dart';
import 'package:map/constants/route_strings.dart';
import 'package:map/persentation/screens/login_screen.dart';
import 'package:map/persentation/screens/otp_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case otpScreen:
        return MaterialPageRoute(
          builder: (_) => OtpScreen(),
        );
      
    }
  }

}