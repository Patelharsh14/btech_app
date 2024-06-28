import 'package:flutter/material.dart';

import 'data.dart';
import 'donor_model.dart';

class DonorProvider with ChangeNotifier {
  final List<Donor> _donors = donors;
  List<Donor> _filteredDonors = donors;

  List<Donor> get filteredDonors => _filteredDonors;

  void searchDonors(String query) {
    if (query.isEmpty) {
      _filteredDonors = _donors;
    } else {
      _filteredDonors = _donors
          .where((donor) =>
              donor.bloodGroup.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
