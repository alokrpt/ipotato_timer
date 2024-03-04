import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/features/task_list/presentation/pages/widgets/empty_state_widget.dart';

void main() {
  testWidgets('EmptyStateWidget widget test', (WidgetTester tester) async {
    // Build the EmptyStateWidget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyStateWidget(),
        ),
      ),
    );

    // Verify that the Text widget with the given text is displayed
    expect(find.text('No timers active. \nPress here to start a new one'),
        findsOneWidget);

    // Verify that the Image widget is displayed
    expect(find.byType(Image), findsOneWidget);
  });
}
