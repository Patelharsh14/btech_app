// ignore_for_file: file_names
import 'package:flutter/material.dart';

class UserDetailsPage extends StatelessWidget {
  final String name;
  final String phone;
  final String state;
  final String bloodGroup;

  const UserDetailsPage({
    super.key,
    required this.name,
    required this.phone,
    required this.state,
    required this.bloodGroup, required List users,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: $name', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Phone: $phone', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('City: $state', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Blood Group: $bloodGroup',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
