import 'package:btech_app/screen-2/BloodDonateRegisterPage.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class blood_donate extends StatefulWidget {
  const blood_donate({super.key});

  @override
  State<blood_donate> createState() => _blood_donateState();
}

// ignore: camel_case_types
class _blood_donateState extends State<blood_donate> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Donation"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Why Donate Blood?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Blood donation is a vital part of healthcare. Donating blood can help save lives and improve the health of those who need it. Your blood donation can make a significant difference to patients in need.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Eligibility to Donate Blood",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "1. You must be in good health and feeling well.\n"
              "2. You must be at least 17 years old.\n"
              "3. You must weigh at least 50 kg.\n"
              "4. You must not have donated blood in the last 56 days.\n"
              "5. You must have a normal blood pressure reading.\n"
              "6. You must not be taking antibiotics for an infection.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BloodDonateRegisterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text("Register to Donate"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
