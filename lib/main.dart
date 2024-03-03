import 'package:flutter/material.dart';
import 'package:ipotato_timer/src/core/dependency_injection/injection_container.dart';
import 'package:ipotato_timer/src/features/add_task/presentation/pages/add_task_dialog.dart';

void main() {
  initDependencyInjection();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iPotato Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iPotato Timer'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: AddTaskDialog(
                    store: sl(),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
