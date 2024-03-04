import 'package:ipotato_timer/src/features/add_task/data/models/task_model.dart';

extension TaskModelTestData on TaskModel {
  static List<TaskModel> get demoTasks => [
        const TaskModel(
          id: 45,
          title: 'Make Food',
          description: 'Make healthy food',
          duration: Duration(seconds: 30),
          isCompleted: false,
        ),
        const TaskModel(
          id: 53,
          title: 'Boil Egg',
          description: '2 eggs every morning',
          duration: Duration(seconds: 46),
          isCompleted: false,
        ),
        const TaskModel(
          id: 22,
          title: 'Run',
          description: 'Daily 2 km',
          duration: Duration(seconds: 350),
          isCompleted: false,
        ),
        const TaskModel(
          id: 222,
          title: 'Exercise',
          description: '',
          duration: Duration(seconds: 5),
          isCompleted: false,
        ),
      ];
}
