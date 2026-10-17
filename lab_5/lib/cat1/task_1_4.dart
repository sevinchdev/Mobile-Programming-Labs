import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: StepScreen(step: 1)));

class StepScreen extends StatelessWidget{
  final int step;
  const StepScreen({super.key, required this.step});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Step $step')),
      body: Center(
        child: step < 4 ?
        ElevatedButton(
          child: const Text("Next"),
          onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => StepScreen(step: step + 1),),);
          }
        )
        : ElevatedButton(
                child: const Text('Finish'),
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
              ),
      ),
    );
  }
}