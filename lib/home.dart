import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      backgroundColor: Colors.white54,
      body: const Center(
        child: Text("Second Screen"),
      ),
    );
  }
}