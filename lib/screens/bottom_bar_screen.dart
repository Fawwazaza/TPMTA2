import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Import semua screen yang dibutuhkan
import 'package:flutter_application_2/screens/home_screen.dart';
import 'package:flutter_application_2/screens/lbs_tracker_screen.dart';
import 'package:flutter_application_2/screens/currency_converter_screen.dart';
import 'package:flutter_application_2/screens/time_converter_screen.dart';
import 'package:flutter_application_2/screens/profile_screen.dart';
import 'package:flutter_application_2/screens/kesan_pesan_screen.dart';
import 'package:flutter_application_2/screens/accelerometer_screen.dart'; // Tambahkan import ini

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _indexData = 0;

  final List<Widget> _listScreen = [
    const HomeScreen(),
    const LbsTrackerScreen(),
    const CurrencyConverterScreen(),
    const TimeConverterScreen(),
    const ProfileScreen(),
    const KesanPesanScreen(),
    AccelerometerScreen(), // Tambahkan sensor screen di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _indexData,
        children: _listScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexData,
        onTap: (value) {
          setState(() {
            _indexData = value;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'LBS Tracker',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.moneyBillTransfer),
            label: 'Konversi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Waktu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Kesan & Pesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors),
            label: 'Sensor',
          ),
        ],
      ),
    );
  }
}
