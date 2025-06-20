class Shoe {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;

  Shoe({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      id: int.parse(json['id'].toString()),
      name: json['nama'],
      price: double.parse(json['harga'].toString()),
      image: json['gambar'],
      description: json['deskripsi'],
    );
  }
}