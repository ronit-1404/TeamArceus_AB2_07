import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mobile/widgets/custom_app_bar.dart';
import 'package:mobile/widgets/donor_card.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorScreen extends StatefulWidget {
  const DonorScreen({super.key});

  @override
  _DonorScreenState createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];
  String searchQuery = '';
  String selectedBloodType = 'All';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final String response = await rootBundle.loadString('lib/data/user.json');
    final data = await json.decode(response);
    setState(() {
      users = data;
      filteredUsers = data;
    });
  }

  void _filterUsers() {
    setState(() {
      filteredUsers =
          users.where((user) {
            final matchesSearchQuery = user['name'].toLowerCase().contains(
              searchQuery.toLowerCase(),
            );
            final matchesBloodType =
                selectedBloodType == 'All' ||
                user['bloodType'] == selectedBloodType;
            return matchesSearchQuery && matchesBloodType;
          }).toList();
    });
  }

  void _showContactModal(BuildContext context, dynamic user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact ${user['name']}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: user['email'],
                  );
                  if (await canLaunch(emailUri.toString())) {
                    await launch(emailUri.toString());
                  } else {
                    // Handle error
                  }
                },
                child: Text(
                  'Email: ${user['email']}',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  final Uri phoneUri = Uri(scheme: 'tel', path: user['phone']);
                  if (await canLaunch(phoneUri.toString())) {
                    await launch(phoneUri.toString());
                  } else {
                    // Handle error
                  }
                },
                child: Text(
                  'Phone: ${user['phone']}',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
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
      appBar: CustomAppBar(
        title: 'Donors',
        user: {},
      ), // Pass the user data here
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 40),
            SizedBox(
              height: 100, // Set the desired height
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Text(
                  'Navigation',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                // Add your log out logic here
              },
            ),
          ],
        ),
      ),
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
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  _filterUsers();
                });
              },
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton<String>(
                value: selectedBloodType,
                isExpanded: true,
                underline: Container(),
                items:
                    <String>[
                      'All',
                      'A+',
                      'A-',
                      'B+',
                      'B-',
                      'AB+',
                      'AB-',
                      'O+',
                      'O-',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBloodType = value!;
                    _filterUsers();
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return DonorCard(
                    name: user['name'],
                    bloodType: user['bloodType'],
                    phone: user['phone'],
                    email: user['email'],
                    age: 30, // Replace with actual age if available
                    sex: 'Unknown', // Replace with actual sex if available
                    medicalHistory:
                        'None', // Replace with actual medical history if available
                    onContactPressed: () => _showContactModal(context, user),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
