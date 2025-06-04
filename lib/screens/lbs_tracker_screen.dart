import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LbsTrackerScreen extends StatefulWidget {
  const LbsTrackerScreen({super.key});

  @override
  State<LbsTrackerScreen> createState() => _LbsTrackerScreenState();
}

class _LbsTrackerScreenState extends State<LbsTrackerScreen> {
  LatLng? _currentLocation;
  String _locationDisplayInfo = "Mencari lokasi...";
  final MapController _mapController = MapController();
  bool _isLoadingLocation = true;
  double _currentZoom = 17.0;
  Timer? _locationUpdateTimer;

  String _previousLatString = '';
  String _previousLongString = '';

  @override
  void initState() {
    super.initState();
    _initializeLocationTracking();
  }

  @override
  void dispose() {
    _locationUpdateTimer?.cancel();
    super.dispose();
  }

  void _handleCenterMap() {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, _currentZoom);
    }
  }

  Future<void> _initializeLocationTracking() async {
    if (!mounted) return;
    setState(() {
      _isLoadingLocation = true;
      _locationDisplayInfo = "Memeriksa izin...";
    });

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        setState(() {
          _locationDisplayInfo =
              "Izin lokasi ditolak. Tidak dapat mengambil lokasi.";
          _isLoadingLocation = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Izin lokasi diperlukan untuk menampilkan lokasi Anda.'),
            ),
          );
        }
        return;
      }
    }

    _startPeriodicLocationUpdate();
  }

  void _startPeriodicLocationUpdate() {
    _locationUpdateTimer?.cancel();

    _locationUpdateTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        if (!mounted) {
          timer.cancel();
          return;
        }
        try {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );

          final newLocation = LatLng(position.latitude, position.longitude);
          final String currentLatString = position.latitude.toStringAsFixed(7);
          final String currentLongString =
              position.longitude.toStringAsFixed(7);

          if (_previousLatString.isEmpty ||
              _previousLatString != currentLatString ||
              _previousLongString != currentLongString) {
            _previousLatString = currentLatString;
            _previousLongString = currentLongString;

            if (mounted) {
              setState(() {
                _currentLocation = newLocation;
                _locationDisplayInfo =
                    "Lat: ${newLocation.latitude.toStringAsFixed(5)}, Lon: ${newLocation.longitude.toStringAsFixed(5)}";
                if (_isLoadingLocation) _isLoadingLocation = false;
              });

              if (_isLoadingLocation == false && _currentLocation != null) {}
              _mapController.move(newLocation, _currentZoom);
            }
          }
        } catch (e) {
          print("Error getting location in timer: $e");
          if (mounted) {
            setState(() {
              _locationDisplayInfo = "Gagal update lokasi: coba lagi...";
            });
          }
        }
      },
    );
    if (mounted && _isLoadingLocation) {
      _locationUpdateTimer?.tick;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LBS Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Lokasi Anda Sekarang :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 500,
                  child: _isLoadingLocation || _currentLocation == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 10),
                              Text(_locationDisplayInfo),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            FlutterMap(
                              mapController: _mapController,
                              options: MapOptions(
                                initialCenter: _currentLocation!,
                                initialZoom: _currentZoom,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: const ['a', 'b', 'c'],
                                  userAgentPackageName: 'com.example.app',
                                ),
                                if (_currentLocation != null)
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: _currentLocation!,
                                        width: 35,
                                        height: 35,
                                        child: const Icon(
                                          Icons.location_pin,
                                          color: Colors.blue,
                                          size: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: FloatingActionButton(
                                onPressed: _handleCenterMap,
                                child: const Icon(Icons.my_location),
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  _currentLocation != null
                      ? "Lat: ${_currentLocation!.latitude.toStringAsFixed(5)}, Lon: ${_currentLocation!.longitude.toStringAsFixed(5)}"
                      : _locationDisplayInfo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
