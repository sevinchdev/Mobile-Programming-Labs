import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(child: const Text('Open sliding from the right'),
        onPressed: (){
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (context, animation, secondaryAnimation) => const DetailsScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                final tween = Tween(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero
                ).chain(CurveTween(curve: Curves.easeInOut));

                return SlideTransition(position: animation.drive(tween),
                child:child );
              },
            )
          );
        },
      ),
    ),
  );
}
}

class DetailsScreen extends StatelessWidget{
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: const Center(child: Text('Hello!'))
      );
  }
}