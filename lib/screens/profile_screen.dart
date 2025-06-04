import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();

  String? _savedNama;
  String? _savedNIM;
  File? _savedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _simpanProfil() {
    if (_namaController.text.isNotEmpty &&
        _nimController.text.isNotEmpty &&
        _image != null) {
      setState(() {
        _savedNama = _namaController.text;
        _savedNIM = _nimController.text;
        _savedImage = _image;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil berhasil disimpan')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lengkapi data profil!')),
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(Icons.add_a_photo, size: 40)
                    : null,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _nimController,
              decoration: InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _simpanProfil,
              child: Text('Simpan Profil'),
            ),
            SizedBox(height: 30),
            if (_savedNama != null && _savedNIM != null && _savedImage != null)
              Column(
                children: [
                  Divider(),
                  Text(
                    'Profil Tersimpan:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(_savedImage!),
                  ),
                  SizedBox(height: 10),
                  Text('Nama: $_savedNama'),
                  Text('NIM: $_savedNIM'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
