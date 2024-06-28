import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'otp.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  String? _selectedBloodGroup;
  String? _selectedRegion;
  String? _selectedState;
  String? _selectedCity;

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  final List<String> _regions = ['India'];

  final Map<String, List<String>> _statesPerRegion = {
    'India': [
      'Gujarat',
      'Maharashtra',
      // Add more states as needed
    ],
  };

  final List<String> _cities = [
    'Ahmedabad',
    'Surat',
    'Vadodara',
    'Rajkot',
    'Bhavnagar',
    'Jamnagar',
    'Junagadh',
    'Gandhinagar',
    'Nadiad',
    'Mehsana',
    'Bharuch',
    'Porbandar',
    // Add more cities as needed
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.uid)
            .set({
          "Name": _nameController.text.trim(),
          "Phone": _phoneController.text.trim(),
          "Email": _emailController.text.trim(),
          "Password": _passwordController.text.trim(),
          "Address": _addressController.text.trim(),
          "PinCode": _pinCodeController.text.trim(),
          "BloodGroup": _selectedBloodGroup,
          "Region": _selectedRegion,
          "State": _selectedState,
          "City": _selectedCity,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User registered successfully"),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to register user: $e"),
          ),
        );
      }
    }
  }

  Future<void> handleRegistration(BuildContext context) async {
    await Future.wait([sendOtp(context), sendSignInLinkToEmail()]);
  }

  Future<void> sendOtp(BuildContext context) async {
    String phoneNumber = '+91' + _phoneController.text.trim();
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 45),
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await FirebaseAuth.instance.signInWithCredential(credential);
            await registerUser();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Error signing in after verification: ${e.toString()}"),
              ),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Verification failed: ${e.message}"),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                verificationId: verificationId,
                onVerificationCompleted: () async {
                  await registerUser();
                },
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error during phone verification: ${e.toString()}"),
        ),
      );
    }
  }

  Future<void> sendSignInLinkToEmail() async {
    try {
      await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: _emailController.text.trim(),
        actionCodeSettings: ActionCodeSettings(
          url:
              'https://yourone.page.link/finishSignUp', // Replace with your dynamic link
          handleCodeInApp: true,
          iOSBundleId:
              'com.example.btech_app', // Replace with your iOS bundle ID
          androidPackageName:
              'com.example.btech_app', // Replace with your Android package name
          androidInstallApp: true,
          androidMinimumVersion: '12',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign-in link sent to email"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send sign-in link: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: 200,
                  child: Lottie.asset(
                    'assets/animation/register.json',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              buildTextField(
                _nameController,
                "Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              buildTextField(
                _phoneController,
                "Phone Number",
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.length != 10) {
                    return 'Please enter a valid 10 digit phone number';
                  }
                  return null;
                },
              ),
              buildTextField(
                _emailController,
                "Email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              buildTextField(
                _passwordController,
                "Password",
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              buildDropdown(
                "Blood Group",
                _bloodGroups,
                _selectedBloodGroup,
                (newValue) {
                  setState(() {
                    _selectedBloodGroup = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your blood group';
                  }
                  return null;
                },
              ),
              buildDropdown(
                "Region",
                _regions,
                _selectedRegion,
                (newValue) {
                  setState(() {
                    _selectedRegion = newValue;
                    _selectedState = null;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your region';
                  }
                  return null;
                },
              ),
              if (_selectedRegion != null &&
                  _statesPerRegion.containsKey(_selectedRegion))
                buildDropdown(
                  "State",
                  _statesPerRegion[_selectedRegion]!,
                  _selectedState,
                  (newValue) {
                    setState(() {
                      _selectedState = newValue;
                      _selectedCity = null;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your state';
                    }
                    return null;
                  },
                ),
              if (_selectedState != null && _cities.isNotEmpty)
                buildDropdown(
                  "City",
                  _cities,
                  _selectedCity,
                  (newValue) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your city';
                    }
                    return null;
                  },
                ),
              buildTextField(
                _addressController,
                "Address",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              buildTextField(
                _pinCodeController,
                "Pin Code",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.length != 6) {
                    return 'Please enter a valid 6 digit pin code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      handleRegistration(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator,
      bool obscureText = false}) {
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
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }

  Widget buildDropdown(String labelText, List<String> items,
      String? selectedItem, ValueChanged<String?> onChanged,
      {String? Function(String?)? validator}) {
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
        validator: validator,
      ),
    );
  }
}
