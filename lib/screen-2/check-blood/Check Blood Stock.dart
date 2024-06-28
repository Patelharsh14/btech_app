// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'donor_provider.dart';

// ignore: camel_case_types
class CheckBlood extends StatefulWidget {
  const CheckBlood({super.key});

  @override
  State<CheckBlood> createState() => _CheckBloodState();
}

// ignore: camel_case_types
class _CheckBloodState extends State<CheckBlood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Blood Donors'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by Blood Group',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                Provider.of<DonorProvider>(context, listen: false)
                    .searchDonors(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<DonorProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.filteredDonors.length,
                  itemBuilder: (context, index) {
                    final donor = provider.filteredDonors[index];
                    return ListTile(
                      title: Text(donor.name),
                      subtitle: Text(donor.bloodGroup),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () => launchUrl(Uri.parse(donor.contact)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
