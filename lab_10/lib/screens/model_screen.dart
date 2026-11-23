import 'package:flutter/material.dart';
import '../credit.dart';
import '../services/classifier.dart';
import '../theme/app_theme.dart';

class ModelScreen extends StatelessWidget {
  const ModelScreen({super.key, required this.classifier});
  final Classifier classifier;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Model')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.l),
          children: [
            _Fact('Classes', '${classifier.labels.length}'),
            _Fact('Input size', '${Classifier.inputSize} × ${Classifier.inputSize}'),
            _Fact('Model file', 'model_unquant.tflite'),
            const SizedBox(height: AppSpacing.m),
            Text('Labels', style: t.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.s),
            Wrap(spacing: AppSpacing.s, runSpacing: AppSpacing.s, children: [
              for (final l in classifier.labels) Chip(label: Text(l)),
            ]),
            const SizedBox(height: AppSpacing.l),
            Text('Design credit', style: t.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.s),
            Text(designCredit, style: t.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact(this.k, this.v);
  final String k, v;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(k, style: Theme.of(context).textTheme.bodyLarge),
          Text(v, style: Theme.of(context).textTheme.titleMedium),
        ]),
      );
}