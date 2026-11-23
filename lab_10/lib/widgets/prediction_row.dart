import 'package:flutter/material.dart';
import '../services/classifier.dart';
import '../theme/app_theme.dart';

class PredictionRow extends StatelessWidget {
  const PredictionRow({super.key, required this.prediction, this.emphasised = false});
  final Prediction prediction;
  final bool emphasised;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final style = emphasised
        ? t.textTheme.titleMedium
        : t.textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s / 2 + 1),
      child: Row(children: [
        SizedBox(width: 88, child: Text(prediction.label, style: style, overflow: TextOverflow.ellipsis)),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: prediction.confidence.clamp(0.0, 1.0),
              minHeight: emphasised ? 10 : 6,
              color: emphasised ? t.colorScheme.primary : t.colorScheme.outline,
              backgroundColor: t.colorScheme.surfaceContainerHighest,
            ),
          ),
        ),
        SizedBox(
          width: 72,
          child: Text('${(prediction.confidence * 100).toStringAsFixed(1)} %',
              textAlign: TextAlign.right, style: style),
        ),
      ]),
    );
  }
}