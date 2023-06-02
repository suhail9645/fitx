import 'package:fitx/src/presentation/views/login_screen/login.dart';
import 'package:fitx/src/presentation/views/splash_screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      title: 'Fitx',
      theme: ThemeData(
        brightness: Brightness.dark,

        primaryColor: Colors.green[800],
        // colorScheme: ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 218, 227, 47)),

        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

