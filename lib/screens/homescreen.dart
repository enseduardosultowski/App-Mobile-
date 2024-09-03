import 'package:flutter/material.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/imagem.jpg'), fit: BoxFit.cover),
        color: Colors.black,
      ),

      );
  }
}