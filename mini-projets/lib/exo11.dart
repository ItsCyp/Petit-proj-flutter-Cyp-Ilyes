/*
Exercice 11 - Application de notes avec Path Provider (fichier local)
*/

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: NotesApp(storage: NotesStorage()),
    ),
  );
}

class NotesStorage {
  // Obtenir le chemin local de l'application
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Obtenir le fichier local
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/notes.txt');
  }

  // Lire les notes
  Future<String> readNotes() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  // Écrire les notes 
  Future<File> writeNotes(String notes) async {
    final file = await _localFile;
    return file.writeAsString(notes);
  }
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key, required this.storage});

  final NotesStorage storage;

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  final TextEditingController _controller = TextEditingController();
  String _notes = '';

  // Initialiser l'état
  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  // Charger les notes enregistrées dans le fichier local
  Future<void> _loadNotes() async {
    final notes = await widget.storage.readNotes();
    setState(() {
      _notes = notes;
      _controller.text = notes;
    });
  }

  // Sauvegarder les notes
  Future<void> _saveNotes() async {
    await widget.storage.writeNotes(_controller.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notes sauvegardées !')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Notes'),
        actions: [
          // Bouton pour sauvegarder les notes (en haut à droite de la page)
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNotes,
            tooltip: 'Sauvegarder',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Zone de texte pour écrire les notes
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: 'Écrivez vos notes ici...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Nettoyer les ressources
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 