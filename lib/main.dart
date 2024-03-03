import 'package:flutter/material.dart';

import 'src/core/constants/color_constants.dart';
import 'src/core/dependency_injection/injection_container.dart';
import 'src/features/task_list/presentation/pages/task_list_screen.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstants.primaryColor,
        ),
        useMaterial3: true,
      ),
      home: TaskListScreen(
        taskListStore: sl(),
      ),
    );
  }
}
