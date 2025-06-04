import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/screens/bottom_bar_screen.dart';
import 'package:flutter_application_2/screens/login_screen.dart';
import 'package:flutter_application_2/screens/accelerometer_screen.dart'; // import screen sensor kamu
import 'services/auth_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Sepatu',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => BottomBarScreen(),
        '/sensor': (context) => AccelerometerScreen(), // tambahkan route sensor di sini
      },
    );
  }
}
