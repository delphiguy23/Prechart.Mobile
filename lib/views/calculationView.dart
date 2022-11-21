import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prechart_mobile/views/navigation.dart';

class CalculationView extends StatelessWidget {
  static const routeName = '/calculation';

  const CalculationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navigation(),
      appBar: AppBar(
        title: const Text('Calculation'),
      ),
      body: Center(
          child: Lottie.asset('assets/animations/under-construction-1.json', repeat: true, reverse: true, animate: true)),
    );
  }
}
