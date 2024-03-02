import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ipotato_timer/src/core/presentation/gap.dart';
import 'package:ipotato_timer/src/core/presentation/text_styles.dart';
import 'package:mobx/mobx.dart';

import 'duration_input_store.dart';

class DurationInputWidget extends StatelessWidget {
  final DurationInputStore store;

  final Function(Duration) onDurationChanged;

  const DurationInputWidget({
    super.key,
    required this.store,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    setupReactions();
    return Row(
      children: [
        Observer(
          builder: (_) => TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) => store.updateHours(int.tryParse(value) ?? 0),
            decoration: const InputDecoration(labelText: 'Hours'),
          ),
        ),
        const Gap(4),
        const Text(': ', style: TextStyles.labelText),
        const Gap(4),
        Observer(
          builder: (_) => TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) => store.updateMinutes(int.tryParse(value) ?? 0),
            decoration: const InputDecoration(labelText: 'Minutes'),
          ),
        ),
        const Gap(4),
        const Text(': ', style: TextStyles.labelText),
        const Gap(4),
        Observer(
          builder: (_) => TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) => store.updateSeconds(int.tryParse(value) ?? 0),
            decoration: const InputDecoration(labelText: 'Seconds'),
          ),
        ),
        const SizedBox(height: 16),
        Observer(
          builder: (_) => Text(
            'Total Duration: ${store.totalDuration}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  void setupReactions() {
    reaction((_) => store.totalDuration, (Duration newValue) {
      onDurationChanged(newValue);
      debugPrint("Duration is now $newValue");
    });
  }
}
