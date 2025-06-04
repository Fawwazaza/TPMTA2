import 'package:flutter/material.dart';

class KesanPesanScreen extends StatefulWidget {
  const KesanPesanScreen({super.key});

  @override
  State<KesanPesanScreen> createState() => _KesanPesanScreenState();
}

class _KesanPesanScreenState extends State<KesanPesanScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _pesanList = [];

  final String _defaultPesan =
      'Mata kuliah Teknologi Mobile sangat membantu memahami '
      'konsep pengembangan aplikasi mobile menggunakan Flutter. '
      'Materi yang diajarkan relevan dan aplikatif untuk dunia kerja.';

  void _tambahPesan() {
    final teks = _controller.text.trim();
    if (teks.isNotEmpty) {
      setState(() {
        _pesanList.add(teks);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kesan & Pesan'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kesan & Pesan Utama:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(_defaultPesan),
            Divider(height: 32, thickness: 1.5),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Masukkan kesan/pesan Anda',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _tambahPesan,
              child: Text('Kirim'),
            ),
            SizedBox(height: 16),
            Text(
              'Kesan/Pesan Tambahan:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: _pesanList.isEmpty
                  ? Text('Belum ada kesan/pesan tambahan.')
                  : ListView.builder(
                      itemCount: _pesanList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(_pesanList[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
