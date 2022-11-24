import 'package:document_solution/Pages/main_page.dart';
import 'package:document_solution/Pages/no_internet_page.dart';
import 'package:document_solution/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'Pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<Helper>(
      create: (_) => Helper(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  //const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();

  static const MaterialColor primaryBlack = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static FirebaseAuth auth = FirebaseAuth.instance;
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  bool hasInternet = true;

  @override
  void initState() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.connected) {
        hasInternet = true;
      } else {
        hasInternet = false;
      }
      setState(() {});
    });
    if (MyApp.auth.currentUser != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A2Z Documentation',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: MyApp.primaryBlack,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
          )),
      home: (hasInternet)
          ? ((isLoggedIn) ? const MainPage() : const LoginPage())
          : const NoInternetPage(),
    );
  }
}
