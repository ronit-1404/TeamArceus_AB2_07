import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _formKey = GlobalKey<FormState>();
  List<dynamic> bloodRequests = [];
  List<String> bloodTypes = [];
  List<String> urgencyLevels = [];
  String _bloodType = 'A+';
  String _urgencyLevel = 'High';
  String _hospitalLocation = '';
  final String apiUrl = 'http://localhost:5000';

  @override
  void initState() {
    super.initState();
    fetchBloodRequests();
  }

  Future<void> fetchBloodRequests() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/api/blood-requests/servicerequest'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          bloodRequests = data;
          bloodTypes = data.map<String>((item) => item['bloodType'] as String).toSet().toList();
          urgencyLevels = data.map<String>((item) => item['urgency'] as String).toSet().toList();
        });
      } else {
        throw Exception('Failed to load blood requests');
      }
    } catch (e) {
      print('Error fetching blood requests: $e');
    }
  }

  Future<void> submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    final Map<String, dynamic> requestData = {
      "recipientId": "user123", // Replace with actual user ID
      "bloodType": _bloodType,
      "urgency": _urgencyLevel,
      "hospital": _hospitalLocation,
      "location": _hospitalLocation, // Assuming hospital and location are the same
    };

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/blood-requests/request-blood'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Blood request submitted successfully!')),
        );
      } else {
        throw Exception('Failed to submit request');
      }
    } catch (e) {
      print('Error submitting blood request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Blood'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(200, 216, 64, 64),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 235, 229, 194),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: _bloodType,
                decoration: const InputDecoration(
                  labelText: 'Blood Type',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                items: bloodTypes
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _bloodType = newValue!;
                  });
                },
                validator: (value) => value == null || value.isEmpty ? 'Please select a blood type' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _urgencyLevel,
                decoration: const InputDecoration(
                  labelText: 'Urgency Level',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                items: urgencyLevels
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _urgencyLevel = newValue!;
                  });
                },
                validator: (value) => value == null || value.isEmpty ? 'Please select an urgency level' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Hospital Location',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter the hospital location' : null,
                onSaved: (value) => _hospitalLocation = value!,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: submitRequest,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                ),
                child: const Text('Submit Request', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
