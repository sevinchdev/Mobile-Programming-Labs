import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeScreen(),
      '/rate': (context) => const RateScreen(),
    },
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const movie = 'Inception';
  int? rating;

  Future<void> rate() async {
    final result =
        await Navigator.pushNamed<int>(context, '/rate', arguments: movie);
    if (!mounted) return;
    if (result != null) {
      setState(() => rating = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(movie, style: TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(
              rating == null ? 'Not rated yet' : 'Movie: $rating/5',
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: rate, child: const Text('Rate')),
          ],
        ),
      ),
    );
  }
}

class RateScreen extends StatelessWidget {
  const RateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text('Rate: $title')),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 1; i <= 5; i++)
              IconButton(
                icon: const Icon(Icons.star, color: Colors.amber),
                onPressed: () => Navigator.pop(context, i),
              ),
          ],
        ),
      ),
    );
  }
}