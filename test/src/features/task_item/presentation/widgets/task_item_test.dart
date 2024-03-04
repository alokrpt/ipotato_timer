import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/dependency_injection/injection_container.dart';
import 'package:ipotato_timer/src/features/task_item/presentation/store/task_item_store.dart';
import 'package:ipotato_timer/src/features/task_item/presentation/widgets/task_item.dart';

import '../../../add_task/data/models/test_data_extension.dart';

void main() {
  initDependencyInjection();
  testWidgets('TaskItem widget test', (WidgetTester tester) async {
    final store = sl<TaskItemStore>();
    final task = TaskModelTestData.demoTasks[0];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskItem(
            task: task,
            taskStore: store,
            onDelete: (int id) {},
          ),
        ),
      ),
    );

    // Verify that the TaskItem displays the correct text
    expect(find.text('Make Food'), findsOneWidget);
    expect(find.text('Make healthy food'), findsOneWidget);
    expect(find.textContaining('00:00:30'), findsOneWidget);

    // Verify that the TaskItem displays the play_arrow icon when not running
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    expect(find.byIcon(Icons.pause), findsNothing);

    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();

    // Verify that the TaskItem displays the pause icon when running
    expect(find.byIcon(Icons.play_arrow), findsNothing);
    expect(find.byIcon(Icons.pause), findsOneWidget);

    expect(find.byIcon(Icons.delete), findsOneWidget);
    store.pauseTask();
    await tester.pump();
  });
}
