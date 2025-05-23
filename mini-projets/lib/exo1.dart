import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            // Image locale
            Image.asset('images/1_5qmJzxqks_PLZAjvNN60AA.webp'),
            // Image en ligne
            Image.network(
              'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
            ),
          ],
        ),
      ),
    ),
  );
}
