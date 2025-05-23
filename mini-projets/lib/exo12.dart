import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

/*
 * Classe Task : Modèle de données pour représenter une tâche dans l'application
 * @HiveType : Annotation pour indiquer que cette classe peut être stockée dans Hive
 * typeId : Identifiant unique pour ce type de données dans Hive
 */
@HiveType(typeId: 0)
class Task extends HiveObject {
  // Champ pour le titre de la tâche
  @HiveField(0)
  String title;

  // Champ pour l'état de complétion de la tâche
  @HiveField(1)
  bool isCompleted;

  // Constructeur avec paramètres nommés
  Task({required this.title, this.isCompleted = false});
}

/*
 * TaskAdapter : Classe qui permet de convertir les objets Task en données binaires
 * et vice versa pour le stockage dans Hive
 */
class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  // Méthode pour convertir les données binaires en objet Task
  @override
  Task read(BinaryReader reader) {
    return Task(
      title: reader.readString(),
      isCompleted: reader.readBool(),
    );
  }

  // Méthode pour convertir un objet Task en données binaires
  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeString(obj.title);
    writer.writeBool(obj.isCompleted);
  }
}

void main() async {
  // Initialisation de Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  // Obtention du répertoire de documents de l'application
  final appDocumentDir = await getApplicationDocumentsDirectory();
  
  // Initialisation de Hive avec le chemin du répertoire
  await Hive.initFlutter(appDocumentDir.path);
  
  // Enregistrement de l'adaptateur pour la classe Task
  Hive.registerAdapter(TaskAdapter());
  
  // Ouverture de la boîte Hive pour stocker les tâches
  await Hive.openBox<Task>('tasks');
  
  // Lancement de l'application
  runApp(const MyApp());
}

/*
 * MyApp : Widget racine de l'application
 * Configure le thème et la page d'accueil
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListScreen(),
    );
  }
}

/*
 * TodoListScreen : Écran principal de l'application
 * Affiche la liste des tâches et permet d'en ajouter/modifier/supprimer
 */
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Contrôleur pour le champ de texte d'ajout de tâche
  final TextEditingController _controller = TextEditingController();
  
  // Référence à la boîte Hive contenant les tâches
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste de tâches avec Hive'),
      ),
      body: Column(
        children: [
          // Zone de saisie pour ajouter une nouvelle tâche
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ajouter une nouvelle tâche',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          // Liste des tâches avec mise à jour automatique
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _taskBox.listenable(),
              builder: (context, Box<Task> box, _) {
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final task = box.getAt(index);
                    return ListTile(
                      title: Text(
                        task!.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) => _toggleTask(index, value!),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTask(index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour ajouter une nouvelle tâche
  void _addTask() {
    if (_controller.text.isNotEmpty) {
      final task = Task(title: _controller.text);
      _taskBox.add(task);
      _controller.clear();
    }
  }

  // Méthode pour basculer l'état de complétion d'une tâche
  void _toggleTask(int index, bool value) {
    final task = _taskBox.getAt(index);
    if (task != null) {
      task.isCompleted = value;
      task.save();
    }
  }

  // Méthode pour supprimer une tâche
  void _deleteTask(int index) {
    _taskBox.deleteAt(index);
  }

  // Nettoyage des ressources lors de la destruction du widget
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}