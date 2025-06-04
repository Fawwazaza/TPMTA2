import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeConverterScreen extends StatefulWidget {
  const TimeConverterScreen({super.key});

  @override
  State<TimeConverterScreen> createState() => _TimeConverterScreenState();
}

class _TimeConverterScreenState extends State<TimeConverterScreen> {
  final List<String> zones = ['WIB', 'WITA', 'WIT', 'London', 'Arab Saudi', 'Amerika'];
  String fromZone = 'WIB';
  String toZone = 'London';
  TimeOfDay selectedTime = TimeOfDay.now();
  String result = '';

  final Map<String, int> zoneOffsets = {
    'WIB': 7,
    'WITA': 8,
    'WIT': 9,
    'London': 1,
    'Arab Saudi': 3,
    'Amerika': -4, // EST (bisa disesuaikan)
  };

  void convertTime() {
    final now = DateTime.now();
    final base = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
    final fromOffset = Duration(hours: zoneOffsets[fromZone]!);
    final toOffset = Duration(hours: zoneOffsets[toZone]!);
    final utc = base.subtract(fromOffset);
    final converted = utc.add(toOffset);

    setState(() {
      result = DateFormat('HH:mm').format(converted) + ' $toZone';
    });
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('Konversi Waktu'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.access_time_filled, size: 60, color: Colors.deepPurple),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickTime,
              child: Text('Pilih Jam (${selectedTime.format(context)})'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fromZone,
                    decoration: InputDecoration(
                      labelText: 'Dari Zona',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: zones.map((zone) => DropdownMenuItem(value: zone, child: Text(zone))).toList(),
                    onChanged: (value) {
                      setState(() {
                        fromZone = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: toZone,
                    decoration: InputDecoration(
                      labelText: 'Ke Zona',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: zones.map((zone) => DropdownMenuItem(value: zone, child: Text(zone))).toList(),
                    onChanged: (value) {
                      setState(() {
                        toZone = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: convertTime,
              icon: const Icon(Icons.sync_alt),
              label: const Text('Konversi Sekarang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 30),
            if (result.isNotEmpty)
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    result,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
