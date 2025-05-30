import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/shoe_api.dart';
import '../widgets/shoe_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Toko Sepatu')),
      body: FutureBuilder(
        future: ShoeApi.getShoes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ShoeCard(shoe: snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}