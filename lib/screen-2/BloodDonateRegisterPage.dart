// ignore_for_file: file_names

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'UserDetailsPage.dart';

class BloodDonateRegisterPage extends StatefulWidget {
  const BloodDonateRegisterPage({super.key});

  @override
  State<BloodDonateRegisterPage> createState() => _BloodDonateRegisterPageState();
}

class _BloodDonateRegisterPageState extends State<BloodDonateRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController(text: "+91");

  String? _selectedBloodGroup;
  String? _selectedRegion;
  String? _selectedState;

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  final List<String> _regions = ['India'];
  final Map<String, List<String>> _statesPerRegion = {
    'India': [
      'Andhra Pradesh',
      'Arunachal Pradesh',
      'Assam',
      'Bihar',
      'Chhattisgarh',
      'Goa',
      'Gujarat',
      'Haryana',
      'Himachal Pradesh',
      'Madhya Pradesh',
      'Maharashtra',
      'Odisha',
      'Punjab',
      'Rajasthan',
      'Tamil Nadu',
      'Tripura',
      'Uttar Pradesh',
      'Uttarakhand',
      'West Bengal'
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Donation Registration"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 200,
                    child: Lottie.asset('assets/animation/blood-donation.json'),
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField(_nameController, "Name"),
                buildTextField(
                  _phoneController,
                  "Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.length != 13) {
                      return 'Please enter a valid 10 digit phone number with country code';
                    }
                    return null;
                  },
                ),
                buildDropdown("Region", _regions, _selectedRegion, (newValue) {
                  setState(() {
                    _selectedRegion = newValue;
                    _selectedState = null; // Reset state selection
                  });
                }),
                if (_selectedRegion != null)
                  buildDropdown(
                    "State",
                    _statesPerRegion[_selectedRegion!]!,
                    _selectedState,
                    (newValue) {
                      setState(() {
                        _selectedState = newValue;
                      });
                    },
                  ),
                buildDropdown("Blood Group", _bloodGroups, _selectedBloodGroup, (newValue) {
                  setState(() {
                    _selectedBloodGroup = newValue;
                  });
                }),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailsPage(
                              name: _nameController.text,
                              phone: _phoneController.text,
                              state: _selectedState!,
                              bloodGroup: _selectedBloodGroup!, users: const [],
                            ),
                          ),
                        );
                        Fluttertoast.showToast(msg: "Registration Successful.");
                      } else {
                        Fluttertoast.showToast(msg: "Please fill all fields correctly.");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget buildDropdown(String labelText, List<String> items, String? selectedItem, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: selectedItem,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select your $labelText' : null,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
