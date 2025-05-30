import 'package:flutter/material.dart';
import '../models/shoe.dart';

class ShoeCard extends StatelessWidget {
  final Shoe shoe;

  const ShoeCard({required this.shoe});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(shoe.image),
        title: Text(shoe.name),
        subtitle: Text("Rp ${shoe.price.toStringAsFixed(0)}"),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}