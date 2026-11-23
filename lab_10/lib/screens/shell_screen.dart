import 'package:flutter/material.dart';
import '../services/classifier.dart';
import '../services/history_store.dart';
import 'history_screen.dart';
import 'home_screen.dart';
import 'model_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key, required this.classifier, required this.history});
  final Classifier classifier;
  final HistoryStore history;
  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: _index, children: [
          HomeScreen(classifier: widget.classifier, history: widget.history),
          HistoryScreen(history: widget.history),
          ModelScreen(classifier: widget.classifier),
        ]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.history), label: 'History'),
            NavigationDestination(icon: Icon(Icons.memory), label: 'Model'),
          ],
        ),
      );
}