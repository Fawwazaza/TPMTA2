import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/shoe.dart';

class ShoeApi {
  static const String _baseUrl = "https://shoes-api-liard.vercel.app/shoes";

  static Future<List<Shoe>> getShoes() async {
    final response = await http.get(Uri.parse("$_baseUrl/shoes"));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Shoe.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load shoes");
    }
  }
}