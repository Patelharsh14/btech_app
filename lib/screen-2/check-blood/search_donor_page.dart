import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'donor_model.dart';
import 'donor_provider.dart';

class SearchDonorPage extends StatefulWidget {
  const SearchDonorPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchDonorPageState createState() => _SearchDonorPageState();
}

class _SearchDonorPageState extends State<SearchDonorPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final donorProvider = Provider.of<DonorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Donors'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter Blood Group',
                labelStyle: const TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  donorProvider.searchDonors(_searchController.text);
                },
                icon: const Icon(Icons.search),
                label: const Text('Search'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: donorProvider.filteredDonors.isNotEmpty
                  ? ListView.builder(
                itemCount: donorProvider.filteredDonors.length,
                itemBuilder: (context, index) {
                  final Donor donor = donorProvider.filteredDonors[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        donor.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Blood Group: ${donor.bloodGroup}\nPhone: ${donor.contact}',
                        style: const TextStyle(height: 1.5),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone, color: Colors.blueAccent),
                        onPressed: () {
                          // Implement phone call functionality here
                        },
                      ),
                    ),
                  );
                },
              )
                  : Center(
                child: Text(
                  'No donors found',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
