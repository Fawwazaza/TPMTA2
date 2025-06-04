import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final List<String> currencies = ['USD', 'MYR', 'IDR', 'EUR'];
  String fromCurrency = 'USD';
  String toCurrency = 'IDR';
  double amount = 0;
  String result = '';

  final Map<String, double> rates = {
    'USD': 1.0,
    'MYR': 4.7,
    'IDR': 15500,
    'EUR': 0.92,
  };

  void convertCurrency() {
    double fromRate = rates[fromCurrency]!;
    double toRate = rates[toCurrency]!;
    double converted = (amount / fromRate) * toRate;

    setState(() {
      result = '${converted.toStringAsFixed(2)} $toCurrency';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('Konversi Mata Uang'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              FontAwesomeIcons.moneyBillWave,
              size: 60,
              color: Colors.teal,
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah Uang',
                prefixIcon: const Icon(Icons.attach_money),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  amount = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fromCurrency,
                    decoration: InputDecoration(
                      labelText: 'Dari',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: currencies.map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        fromCurrency = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: toCurrency,
                    decoration: InputDecoration(
                      labelText: 'Ke',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: currencies.map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        toCurrency = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: convertCurrency,
              icon: const Icon(Icons.sync_alt),
              label: const Text('Konversi Sekarang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 5,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(FontAwesomeIcons.calculator, color: Colors.teal),
                      const SizedBox(width: 10),
                      Text(
                        result,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
