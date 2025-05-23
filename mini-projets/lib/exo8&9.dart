import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Point d'entrée principal de l'application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // On démarre sur le premier écran
    return MaterialApp(
      home: const FirstScreen(),
    );
  }
}

// Premier écran qui reçoit le pseudo depuis le second écran
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String? pseudo; // Stocke le pseudo reçu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Premier écran')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Entrer un pseudo'),
              onPressed: () async {
                // On passe le pseudo actuel à la seconde page
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(
                      pseudoInitial: pseudo ?? '', // Argument transmis
                    ),
                  ),
                );
                // Si un pseudo est retourné, on le stocke
                if (result != null) {
                  setState(() {
                    pseudo = result;
                  });
                }
              },
            ),
            // Affiche le pseudo reçu si présent
            if (pseudo != null) Text('Pseudo reçu : $pseudo'),
          ],
        ),
      ),
    );
  }
}

// Second écran qui permet de saisir un pseudo
class SecondScreen extends StatefulWidget {
  final String pseudoInitial; // Argument reçu du premier écran

  const SecondScreen({super.key, required this.pseudoInitial});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Initialise le champ texte avec le pseudo reçu
    _controller = TextEditingController(text: widget.pseudoInitial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrer un pseudo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Champ de saisie du pseudo
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Pseudo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Valider'),
              onPressed: () {
                // Retourne la valeur saisie à l'écran précédent
                Navigator.pop(context, _controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
