import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/image_sources.dart';
import '../theme/app_theme.dart';

/// Returns the downloaded bytes, or null if the user cancels.
Future<Uint8List?> showUrlDialog(BuildContext context, ImageSources sources) =>
    showDialog<Uint8List>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _UrlDialog(sources: sources),
    );

class _UrlDialog extends StatefulWidget {
  const _UrlDialog({required this.sources});
  final ImageSources sources;
  @override
  State<_UrlDialog> createState() => _UrlDialogState();
}

class _UrlDialogState extends State<_UrlDialog> {
  final _controller = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _download() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final bytes = await widget.sources.fromUrl(_controller.text);
      if (mounted) Navigator.of(context).pop(bytes);
    } on ImageSourceException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } catch (e) {
      if (mounted) setState(() => _error = 'Download failed: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return AlertDialog(
      title: const Text('Download an image'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            enabled: !_loading,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(hintText: 'https://…/picture.jpg'),
          ),
          const SizedBox(height: AppSpacing.m),
          if (_loading)
            const Row(children: [
              SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
              SizedBox(width: AppSpacing.m),
              Text('Downloading…'),
            ]),
          if (_error != null)
            Text(_error!, style: t.textTheme.bodyMedium?.copyWith(color: t.colorScheme.error)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
          onPressed: _loading ? null : _download,
          child: const Text('Download'),
        ),
      ],
    );
  }
}