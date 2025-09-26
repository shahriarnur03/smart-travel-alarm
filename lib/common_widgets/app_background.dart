import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  
  const AppBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFF082257), // #082257
            Color(0xFF0B0024), // #0B0024
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: child,
    );
  }
}