import 'package:flutter/material.dart';
import 'package:lab_5/cat5/task_5_2.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(child: const Text('Slide from bottom'),
        onPressed: (){
          Navigator.push(context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
              const DetailsScreen(),
            transitionsBuilder: ((context, animation, secondaryAnimation, child){
              final tween = Tween(
                begin: Offset(0.0, 1.0),
                end: Offset.zero
              );

              final customCurvedAnimation = CurvedAnimation(parent: animation, 
              curve: Curves.easeOut);

              return SlideTransition(position: tween.animate(customCurvedAnimation),
              child:child);
            } ))
          );
        },
      ),
    ),
  );
}
}