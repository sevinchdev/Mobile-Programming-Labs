import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/history_entry.dart';
import '../services/classifier.dart';
import '../services/history_store.dart';
import '../services/image_sources.dart';
import '../theme/app_theme.dart';
import '../widgets/url_dialog.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.classifier, required this.history});
  final Classifier classifier;
  final HistoryStore history;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _sources = ImageSources();
  bool _busy = false;

  /// bytes -> classify -> History -> Result. Every source ends up here.
  Future<void> _process(Uint8List bytes, Source source) async {
    setState(() => _busy = true);
    await Future<void>.delayed(const Duration(milliseconds: 50)); // let the spinner paint
    try {
      final sw = Stopwatch()..start();
      final predictions = widget.classifier.classify(bytes);
      debugPrint('classify took ${sw.elapsedMilliseconds} ms');
      final entry = HistoryEntry(bytes, predictions, source);
      widget.history.add(entry);
      if (!mounted) return;
      await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ResultScreen(entry: entry)));
    } catch (e) {
      _showError('Could not classify this image: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _fromCamera() async {
    try {
      final bytes = await _sources.fromCamera();
      if (bytes != null) await _process(bytes, Source.camera); // null = cancelled
    } catch (e) {
      _showError('Could not use the camera: $e');
    }
  }

  Future<void> _fromGallery() async {
    try {
      final bytes = await _sources.fromGallery();
      if (bytes != null) await _process(bytes, Source.gallery);
    } catch (e) {
      _showError('Could not open the gallery: $e');
    }
  }

  Future<void> _fromUrl() async {
    final bytes = await showUrlDialog(context, _sources);
    if (bytes != null) await _process(bytes, Source.download);
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Recognise')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.l),
          children: [
            if (_busy) const LinearProgressIndicator(),
            _ActionCard(
              icon: Icons.photo_camera_outlined,
              title: 'Take a photo',
              subtitle: 'Use the phone camera',
              onTap: _busy ? null : _fromCamera,
            ),
            _ActionCard(
              icon: Icons.photo_library_outlined,
              title: 'Choose from gallery',
              subtitle: 'Pick an existing picture',
              onTap: _busy ? null : _fromGallery,
            ),
            _ActionCard(
              icon: Icons.cloud_download_outlined,
              title: 'Download an image',
              subtitle: 'Paste an image address',
              onTap: _busy ? null : _fromUrl,
            ),
            const SizedBox(height: AppSpacing.l),
            Text('Latest result', style: t.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.s),
            ListenableBuilder(
              listenable: widget.history,
              builder: (context, _) {
                final e = widget.history.latest;
                if (e == null) {
                  return Text('Nothing classified yet.', style: t.textTheme.bodyMedium);
                }
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(e.bytes,
                          width: 56, height: 56, fit: BoxFit.cover, cacheWidth: 112),
                    ),
                    title: Text(e.top.label),
                    subtitle: Text('${(e.top.confidence * 100).toStringAsFixed(1)} %'),
                    trailing: Icon(e.source.icon),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ResultScreen(entry: e))),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
  final IconData icon;
  final String title, subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.m),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile( // ListTile with onTap gives the pressed (ripple) state
            contentPadding: const EdgeInsets.all(AppSpacing.m),
            leading: Icon(icon, size: 32),
            title: Text(title, style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: onTap,
          ),
        ),
      );
}