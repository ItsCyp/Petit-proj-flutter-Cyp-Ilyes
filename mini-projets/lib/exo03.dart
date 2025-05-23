import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercice 3 : ListView',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exercice 3 : ListView'),
        ),
        body: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Élément 1'),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Élément 2'),
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Élément 3'),
            ),
          ],
        ),
      ),
    );
  }
}
