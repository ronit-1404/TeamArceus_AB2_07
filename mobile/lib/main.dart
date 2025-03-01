import 'package:flutter/material.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/login_screen.dart';
import 'package:mobile/screens/donor_screen.dart';
import 'package:mobile/screens/request_screen.dart';
import 'package:mobile/screens/profile_screen.dart';
import 'package:mobile/screens/notification_screen.dart';
import 'package:mobile/screens/sos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Load user data from JSON
    final user = {
      "id": "65f1a8c9b4a3e5d2c8f1e4a2",
      "name": "John Doe",
      "email": "john.doe@example.com",
      "phone": "123-456-7890",
      "bloodType": "O+",
      "address": "123 Main St, NY",
      "isDonor": true,
      "isActive": true,
      "donationHistory": [
        {"date": "2025-02-28", "location": "NY Blood Center"},
      ],
    };

    return MaterialApp(
      title: 'Blood Donation & Emergency Help',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/login',
      routes: {
        '/': (context) => HomeScreen(user: user),
        '/login': (context) => const LoginScreen(),
        '/donor': (context) => const DonorScreen(),
        '/request': (context) => const RequestScreen(),
        '/profile': (context) => ProfileScreen(user: user),
        '/sos': (context) => const SosScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/notifications') {
          final userId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => NotificationScreen(userId: userId),
          );
        }
        return null;
      },
    );
  }
}
