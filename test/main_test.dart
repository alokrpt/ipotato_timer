import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/main.dart';
import 'package:ipotato_timer/src/core/dependency_injection/injection_container.dart';
import 'package:ipotato_timer/src/features/add_task/presentation/pages/widgets/button_item.dart';
import 'package:ipotato_timer/src/features/task_list/presentation/pages/widgets/empty_state_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  initDependencyInjection();
  testWidgets('Initial home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify home page opened.
    expect(find.text('iPotato Timer'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Check for loading state
    expect(find.textContaining('00'), findsNothing);
    expect(
      find.byWidget(const EmptyStateWidget()),
      findsNothing,
    );
    expect(
      find.byWidgetPredicate(
          (Widget widget) => widget is CircularProgressIndicator),
      findsOneWidget,
    );

    // Tap the floating action button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that add task form has opened.
    expect(find.text('Add Task'), findsAtLeast(2));
    expect(find.text('Title'), findsOneWidget);

    // Enter text into the Title field
    await tester.enterText(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField && widget.decoration?.labelText == 'Title'),
        'Task title');

    // Verify that the text was entered correctly
    expect(find.text('Task title'), findsOneWidget);

    // Enter text into the description field
    await tester.enterText(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField &&
            widget.decoration?.labelText == 'Description'),
        'Task Desc');

    // Verify that the text was entered correctly
    expect(find.text('Task Desc'), findsOneWidget);

    // Enter text into the seconds field
    await tester.enterText(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField && widget.decoration?.labelText == 'SS'),
        '30');

    // Verify that the text was entered correctly
    expect(find.text('30'), findsOneWidget);

    await tester
        .tap(find.byWidgetPredicate((Widget widget) => widget is ButtonItem));
    await tester.pump();
    expect(find.byWidgetPredicate((Widget widget) => widget is ButtonItem),
        findsNothing);
    expect(
        find.byWidgetPredicate(
            (Widget widget) => widget is CircularProgressIndicator),
        findsAtLeast(1));
  });
}
