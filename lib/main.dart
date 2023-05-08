import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiendita/models/app_user.dart';
import 'package:tiendita/screens/admin/admin_bloc.dart';
import 'package:tiendita/screens/admin/admin_screen.dart';
import 'package:tiendita/screens/home/home_bloc.dart';
import 'package:tiendita/screens/home/home_screen.dart';
import 'package:tiendita/screens/login/login_bloc.dart';
import 'package:tiendita/screens/login/login_screen.dart';

void main() async {
  FirebaseApp defaultApp = await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCZJvQ7zZN_R5Uc5SpUY74LJ7C9ugV02qs",
    authDomain: "tiendita-86c30.firebaseapp.com",
    projectId: "tiendita-86c30",
    storageBucket: "tiendita-86c30.appspot.com",
    messagingSenderId: "760148535400",
    appId: "1:760148535400:web:356ba41f8dc30078b973dd",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiendita de la honestidad',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = ChangeNotifierProvider(
              create: (_) => LoginBloc(),
              child: LoginScreen(),
            );
            break;
          case '/home':
            final user = settings.arguments as AppUser;
            if (user == null) {
              page = ChangeNotifierProvider(
                  create: (_) => LoginBloc(), child: LoginScreen());
            } else {
              page = ChangeNotifierProvider(
                  create: (_) => HomeBloc(user: user), child: HomeScreen());
            }
            break;
          case '/admin':
            page = ChangeNotifierProvider(
                create: (_) => AdminBloc(), child: AdminScreen());
            break;
          default:
            page = ChangeNotifierProvider(
              create: (_) => LoginBloc(),
              child: LoginScreen(),
            );
        }
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      },
    );
  }
}
