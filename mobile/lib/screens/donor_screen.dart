import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile/widgets/donor_card.dart';

class DonorScreen extends StatefulWidget {
  const DonorScreen({super.key});

  @override
  _DonorScreenState createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
  final List<Map<String, dynamic>> _donors = List.generate(
    5,
    (index) => {
      'name': 'Donor ${index + 1}',
      'bloodType': 'A+',
      'phone': '1234567890',
      'email': 'donor${index + 1}@example.com',
      'age': 30 + index,
      'sex': index % 2 == 0 ? 'Male' : 'Female',
      'medicalHistory': 'No significant medical history',
    },
  );

  void _showContactModal(
    BuildContext context,
    String name,
    String phone,
    String email,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Contact $name',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.call, color: Colors.white),
                title: const Text(
                  'Call',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  final Uri launchUri = Uri(scheme: 'tel', path: phone);
                  if (await canLaunchUrl(launchUri)) {
                    await launchUrl(launchUri);
                  } else {
                    throw 'Could not launch $launchUri';
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.email, color: Colors.white),
                title: const Text(
                  'Email',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  final Uri launchUri = Uri(scheme: 'mailto', path: email);
                  if (await canLaunchUrl(launchUri)) {
                    await launchUrl(launchUri);
                  } else {
                    throw 'Could not launch $launchUri';
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donor Screen'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            const Text(
              'Available Donors',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _donors.length,
                itemBuilder: (context, index) {
                  final donor = _donors[index];
                  return DonorCard(
                    name: donor['name'],
                    bloodType: donor['bloodType'],
                    phone: donor['phone'],
                    email: donor['email'],
                    age: donor['age'],
                    sex: donor['sex'],
                    medicalHistory: donor['medicalHistory'],
                    onContactPressed: () {
                      _showContactModal(
                        context,
                        donor['name'],
                        donor['phone'],
                        donor['email'],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final newDonor = await Navigator.pushNamed(
                  context,
                  '/add_donor',
                );
                if (newDonor != null) {
                  setState(() {
                    _donors.add(newDonor as Map<String, dynamic>);
                  });
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Donor'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
