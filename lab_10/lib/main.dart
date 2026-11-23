
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'services/classifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final classifier = await Classifier.load();
  final data = await rootBundle.load('assets/model/sample.jpg');
  final bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  final results = classifier.classify(bytes);
  var sum = 0.0;
  for (final p in results) {
    debugPrint('${p.label}: ${(p.confidence * 100).toStringAsFixed(1)} %');
    sum += p.confidence;
  }
  debugPrint('Sum of confidences: $sum');
  runApp(const MaterialApp(
    home: Scaffold(body: Center(child: Text('Smoke test: see the console'))),
  ));
}