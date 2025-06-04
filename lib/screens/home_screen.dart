import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/shoe.dart'; // Pastikan path ini benar
import '../services/shoe_api.dart'; // Pastikan path ini benar
import '../widgets/shoe_card.dart'; // Pastikan path ini benar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Shoe> _masterShoeList = [];
  List<Shoe> _displayedShoeList = [];
  Future<List<Shoe>>? _fetchShoesFuture;

  bool _isDataInitialized = false;
  String _currentSearchQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchShoesFuture = ShoeApi.getShoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toko Sepatu')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                _currentSearchQuery = value.toLowerCase();
                setState(() {
                  if (_currentSearchQuery.isEmpty) {
                    _displayedShoeList = List.from(_masterShoeList);
                  } else {
                    _displayedShoeList = _masterShoeList
                        .where(
                          (element) => element.name
                              .toLowerCase()
                              .contains(_currentSearchQuery),
                        )
                        .toList();
                  }
                });
              },
              decoration: InputDecoration(
                labelText: 'Cari Sepatu ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Shoe>>(
                future: _fetchShoesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Error loading data: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    if (!_isDataInitialized) {
                      _masterShoeList = snapshot.data ?? [];
                      if (_currentSearchQuery.isEmpty) {
                        _displayedShoeList = List.from(_masterShoeList);
                      } else {
                        _displayedShoeList = _masterShoeList
                            .where((element) => element.name
                                .toLowerCase()
                                .contains(_currentSearchQuery))
                            .toList();
                      }
                      _isDataInitialized = true;
                    }

                    if (_masterShoeList.isEmpty && _isDataInitialized) {
                      return const Center(
                          child: Text("Tidak ada data sepatu."));
                    }

                    if (_displayedShoeList.isEmpty &&
                        _currentSearchQuery.isNotEmpty) {
                      return const Center(
                          child: Text("Sepatu tidak ditemukan."));
                    }

                    return ListView.builder(
                      itemCount: _displayedShoeList.length,
                      itemBuilder: (context, index) {
                        return ShoeCard(shoe: _displayedShoeList[index]);
                      },
                    );
                  }
                  return const Center(
                      child: Text("Tidak ada data untuk ditampilkan."));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
