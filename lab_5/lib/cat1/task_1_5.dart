import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: RootScreen()));

class BackOrExitButton extends StatelessWidget {
  const BackOrExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final canGoBack = Navigator.canPop(context);
    return ElevatedButton(
      onPressed: canGoBack ? () => Navigator.pop(context) : null,
      child: Text(canGoBack ? 'Back' : 'Nothing to go back to'),
    );
  }
}

class RootScreen extends StatelessWidget{
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Root')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BackOrExitButton(),
            const SizedBox(height: 12),
            ElevatedButton(
              child: const Text('Open pushed screen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PushedScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PushedScreen extends StatelessWidget{
  const PushedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pushed')),
      body: const Center(child: BackOrExitButton()),
    );
  }

}