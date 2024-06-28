import 'package:btech_app/screen-1/homepage.dart';
import 'package:btech_app/screen-1/logout.dart';
import 'package:btech_app/screen-1/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _pageIndex = 0;
  final List<Widget> _pages = [
    const Homepage(),
    const AdminLoginPage(),
    const Logout(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageIndex == 0
            ? "Homepage"
            : _pageIndex == 1
                ? "Admin"
                : "Logout"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: _pages[_pageIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.orange,
        height: 60,
        items: const [
          Icon(Icons.home_outlined, size: 30, color: Colors.white),
          Icon(Icons.person_outlined, size: 30, color: Colors.white),
          Icon(Icons.logout_sharp, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
