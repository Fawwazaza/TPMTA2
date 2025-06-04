import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerScreen extends StatefulWidget {
  @override
  _AccelerometerScreenState createState() => _AccelerometerScreenState();
}

class _AccelerometerScreenState extends State<AccelerometerScreen> {
  double x = 0.0, y = 0.0, z = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sensor Accelerometer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Akselerasi X: ${x.toStringAsFixed(2)}'),
            Text('Akselerasi Y: ${y.toStringAsFixed(2)}'),
            Text('Akselerasi Z: ${z.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
