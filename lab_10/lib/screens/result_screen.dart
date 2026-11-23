import 'package:flutter/material.dart';
import '../models/history_entry.dart';
import '../theme/app_theme.dart';
import '../widgets/prediction_row.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.entry});
  final HistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final maxImage = MediaQuery.sizeOf(context).height * 0.5;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.l),
            child: Row(children: [
              Icon(entry.source.icon, size: 18),
              const SizedBox(width: AppSpacing.s),
              Text(entry.source.label),
            ]),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.l),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxImage),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(entry.bytes, fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            for (var i = 0; i < entry.predictions.length; i++)
              PredictionRow(prediction: entry.predictions[i], emphasised: i == 0),
          ],
        ),
      ),
    );
  }
}