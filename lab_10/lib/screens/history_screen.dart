import 'package:flutter/material.dart';
import '../services/history_store.dart';
import '../theme/app_theme.dart';
import 'result_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.history});
  final HistoryStore history;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: ListenableBuilder(
        listenable: history,
        builder: (context, _) {
          final items = history.items;
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.l),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.image_search, size: 64, color: t.colorScheme.outline),
                  const SizedBox(height: AppSpacing.m),
                  Text('No classifications yet', style: t.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.s),
                  Text('Pictures you classify will show up here.',
                      style: t.textTheme.bodyMedium, textAlign: TextAlign.center),
                ]),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.l),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s),
            itemBuilder: (context, i) {
              final e = items[i];
              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(e.bytes, width: 56, height: 56,
                        fit: BoxFit.cover, cacheWidth: 112),
                  ),
                  title: Text(e.top.label),
                  subtitle: Text('${(e.top.confidence * 100).toStringAsFixed(1)} %'),
                  trailing: Icon(e.source.icon),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ResultScreen(entry: e))),
                ),
              );
            },
          );
        },
      ),
    );
  }
}