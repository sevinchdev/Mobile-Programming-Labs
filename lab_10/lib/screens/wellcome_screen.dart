import 'package:flutter/material.dart';
import '../credit.dart';
import '../services/classifier.dart';
import '../theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
    required this.classifier,
    required this.error,
    required this.onRetry,
    required this.onStart,
  });
  final Classifier? classifier;
  final Object? error;
  final VoidCallback onRetry, onStart;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.l),
                      Text(appName, style: t.textTheme.headlineLarge),
                      const SizedBox(height: AppSpacing.m),
                      Text('Recognises the objects I trained it on, fully offline.',
                          style: t.textTheme.bodyLarge),
                      const SizedBox(height: AppSpacing.l),
                      if (classifier != null)
                        Wrap(spacing: AppSpacing.s, runSpacing: AppSpacing.s, children: [
                          for (final l in classifier!.labels) Chip(label: Text(l)),
                        ])
                      else if (error != null)
                        _ErrorBox(error: error!, onRetry: onRetry)
                      else
                        const Row(children: [
                          SizedBox(
                              width: 20, height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2)),
                          SizedBox(width: AppSpacing.m),
                          Text('Loading model…'),
                        ]),
                    ],
                  ),
                ),
              ),
              FilledButton(
                onPressed: classifier == null ? null : onStart,
                child: const Text('Get started'),
              ),
              const SizedBox(height: AppSpacing.s),
              Text(designCredit, style: t.textTheme.bodyMedium, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.error, required this.onRetry});
  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Model could not be loaded',
              style: t.textTheme.titleMedium?.copyWith(color: t.colorScheme.error)),
          const SizedBox(height: AppSpacing.s),
          Text('Expected assets/model/model_unquant.tflite and assets/model/labels.txt.',
              style: t.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.s),
          Text('$error', style: t.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.m),
          OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
        ]),
      ),
    );
  }
}