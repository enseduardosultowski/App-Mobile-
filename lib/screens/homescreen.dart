import 'package:flutter/material.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.black,
      child: Container(
              width: 5,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 216, 216),
                borderRadius: BorderRadius.circular(100)
              )
    ),
    );
  }
}