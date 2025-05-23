/*
Exercice 4 et 6 (utilisation des états)
  Exemple de bouton, checkbox, radio
  Cette exemple utilise egalement les état donc setState() 
  car on change le texte en fonction de la case à cocher et du bouton radio
 */


import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter exemple bouton, checkbox, radio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> mots = ['Bonjour', 'Hello', 'Hola', 'Hallo', 'Ciao']; // Liste de mots
  int index = 0; // Index de la liste
  String current = ""; // Texte a afficher 
  String _selectedRadio = 'exemple1'; // BOuton radio selectionné
  bool _isChecked = false; // Case à cocher

  // Fonction pour changer le texte
  void updateText() {
    setState(() { 
      current = mots[index];
      index = index == (mots.length - 1) ? 0 : index + 1; // Si l'index est le dernier, on le remet à 0, sinon on incrémente l'index
    });
  }

  @override
  void initState() {
    super.initState();
    updateText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter exemple bouton, checkbox, radio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texte a afficher (ici "Bonjour")
            Text(current, style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 20),
            
            // Bouton pour changer le texte
            ElevatedButton(
              onPressed: updateText,
              child: const Text('Exemple de bouton'),
            ),
            const SizedBox(height: 20),

            // Case à cocher
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                      if (_isChecked) { // Si la case est cochée ou pas, on change le texte en conséquence
                        current = "Coché"; 
                      } else {
                        current = "Non coché";
                      }
                    });
                  },
                ),
                const Text('Exemple de case à cocher'),
              ],
            ),
            const SizedBox(height: 20),

            // Bouton radio
              RadioListTile(
                title: const Text('Exemple 1'),
                value: 'exemple1',
                groupValue: _selectedRadio,
                onChanged: (String? value) {
                  setState(() {
                    _selectedRadio = value ?? 'exemple1';
                    current = "Exemple 1 selectionné";
                  });
                },
              ),
              RadioListTile(
                title: const Text('Exemple 2'),
                value: 'exemple2',
                groupValue: _selectedRadio,
                onChanged: (String? value) {
                  setState(() {
                    _selectedRadio = value ?? 'exemple2';
                    current = "Exemple 2 selectionné";
                  });
                },
              ),
              RadioListTile(
                title: const Text('Exemple 3'),
                value: 'exemple3',
                groupValue: _selectedRadio,
                onChanged: (String? value) {
                  setState(() {
                    _selectedRadio = value ?? 'exemple3';
                    current = "Exemple 3 selectionné";
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}

