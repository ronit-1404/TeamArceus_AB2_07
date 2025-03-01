import 'package:flutter/material.dart';

class DonorCard extends StatelessWidget {
  final String name;
  final String bloodType;
  final String phone;
  final String email;
  final int age;
  final String sex;
  final String medicalHistory;
  final VoidCallback onContactPressed;

  const DonorCard({
    Key? key,
    required this.name,
    required this.bloodType,
    required this.phone,
    required this.email,
    required this.age,
    required this.sex,
    required this.medicalHistory,
    required this.onContactPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text('Blood Type: $bloodType'),
            Text('Age: $age'),
            Text('Sex: $sex'),
            Text('Medical History: $medicalHistory'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text('Phone: $phone'), Text('Email: $email')],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onContactPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
