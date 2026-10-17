import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ColorScreen()));

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  Color color = Colors.grey;

  Future<void> chooseColor() async {
    final chosen = await Navigator.push<Color>(
      context,
      MaterialPageRoute(builder: (context) => const PickerScreen()),
    );
    if (!mounted) return;
    if (chosen != null) {
      setState(() => color = chosen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current colour')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 120, height: 120, color: color),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: chooseColor,
              child: const Text('Choose colour'),
            ),
          ],
        ),
      ),
    );
  }
}

class PickerScreen extends StatelessWidget {
  const PickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick one')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final c in [Colors.red, Colors.green, Colors.blue])
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: c),
                  onPressed: () => Navigator.pop(context, c),
                  child: const Text('Choose'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}