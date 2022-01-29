import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:map/constants/route_strings.dart';
import 'package:map/persentation/screens/login_screen.dart';
import 'package:map/persentation/screens/map_screen.dart';
import 'package:map/persentation/screens/otp_screen.dart';

class AppRouter {

  PhoneAuthCubit? phoneAuthCubit;

  // I'm create Constractor here, becouse i will use the cubit in differant screens, that' Why ?!
  // I'm will use the Cubit twice
  AppRouter(){
    phoneAuthCubit = PhoneAuthCubit();
  }


  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );
      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
      case mapScreen:
        return MaterialPageRoute(
          builder: (_) => const MapScreen(),
        );
    }
  }
}
