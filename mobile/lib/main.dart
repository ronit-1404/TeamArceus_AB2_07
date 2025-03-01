import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/donor_screen.dart';
import 'screens/request_screen.dart';
import 'screens/sos_screen.dart';
import 'screens/add_donor_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation & Emergency Help',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/donor': (context) => const DonorScreen(),
        '/request': (context) => const RequestScreen(),
        '/sos': (context) => const SosScreen(),
        '/add_donor': (context) => const AddDonorScreen(),
      },
    );
  }
}
