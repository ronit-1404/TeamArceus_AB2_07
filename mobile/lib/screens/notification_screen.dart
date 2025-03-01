import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class NotificationScreen extends StatefulWidget {
  final String userId;

  const NotificationScreen({super.key, required this.userId});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> notifications = [];

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final String response = await rootBundle.loadString(
      'lib/data/notification.json',
    );
    final data = await json.decode(response);
    setState(() {
      notifications =
          data
              .where((notification) => notification['userId'] == widget.userId)
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child:
            notifications.isEmpty
                ? const Center(
                  child: Text(
                    'No notifications available.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
                : ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Card(
                      color:
                          notification['read']
                              ? Colors.white
                              : Colors.grey[300],
                      child: ListTile(
                        title: Text(notification['message']),
                        trailing:
                            notification['read']
                                ? const Icon(Icons.check, color: Colors.green)
                                : const Icon(
                                  Icons.notifications,
                                  color: Colors.red,
                                ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
