import 'package:flutter/material.dart';
import 'credit.dart';
import 'screens/shell_screen.dart';
import 'screens/wellcome_screen.dart';
import 'services/classifier.dart';
import 'services/history_store.dart';
import 'theme/app_theme.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _history = HistoryStore();
  Classifier? _classifier;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final c = await Classifier.load();
      if (!mounted) return c.close();
      setState(() => _classifier = c);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  void dispose() {
    _classifier?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appName,
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => WelcomeScreen(
            classifier: _classifier,
            error: _error,
            onRetry: _load,
            onStart: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => ShellScreen(classifier: _classifier!, history: _history),
            )),
          ),
        ),
      );
}