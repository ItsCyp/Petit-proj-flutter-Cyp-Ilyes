/*
  Exercice 2
  Exemple de widgets Row, Column, Center
*/

import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets Row, Column, Center',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets Row, Column, Center'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CenterDemo()),
                );
              },
              child: const Text('Voir un Widget Center'),
            ),
            const SizedBox(height: 20), // padding de 20px
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ColumnDemo()),
                );
              },
              child: const Text('Voir un Widget Column'),
            ),
            const SizedBox(height: 20), // padding de 20px
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RowDemo()),
                );
              },
              child: const Text('Voir un Widget Row'),
            ),
          ],
        ),
      ),
    );
  }
}

class CenterDemo extends StatelessWidget {
  const CenterDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Center'),
      ),
      body: Center(
        child: Container( // un conteneur qui aura la forme d'un carré bleu
          width: 200,
          height: 200,
          color: Colors.blue,

        ),
      ),
    );
  }
}

class ColumnDemo extends StatelessWidget {
  const ColumnDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Column'),
      ),
      body: Column( // une column avec 3 conteneurs qui auront la forme d'un carré
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
            margin: const EdgeInsets.all(8),
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.green,
            margin: const EdgeInsets.all(8),
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            margin: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}

class RowDemo extends StatelessWidget {
  const RowDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row'),
      ),
      body: Row( // un row avec 3 conteneurs qui auront la forme d'un carré
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.yellow,
              margin: const EdgeInsets.all(8),
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.purple,
              margin: const EdgeInsets.all(8),
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.orange,
              margin: const EdgeInsets.all(8),
            ),
          ],
        ),
    );
  }
}

