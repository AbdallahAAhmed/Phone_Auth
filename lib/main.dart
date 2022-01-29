import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:map/app_router.dart';
import 'package:map/constants/route_strings.dart';

// this is variable for set the inital Route
late String initialRoute;

void main() async {
  // You only need to call this method if you need the binding to be initialized before calling runApp.
  // to prepare flutter framework to initialize and use the native code and work with Rest api and firebase api
  WidgetsFlutterBinding.ensureInitialized();
  // before any functionallity, to use firebase services you should initialize firebase before run app
  await Firebase.initializeApp(); // necessary to use firebase services

  // this is method from firebase do what is shared Preferance do, but from firebase.
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if(user == null) {
      initialRoute = loginScreen;
    }else {
      initialRoute = mapScreen;
    }
  });

  runApp(MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: initialRoute,
    );
  }
}