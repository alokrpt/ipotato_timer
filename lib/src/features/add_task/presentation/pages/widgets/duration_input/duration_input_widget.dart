import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../core/presentation/gap.dart';
import '../../../../../../core/presentation/text_styles.dart';
import 'duration_input_store.dart';

class DurationInputWidget extends StatefulWidget {
  final DurationInputStore store;

  final Function(Duration) onDurationChanged;

  const DurationInputWidget({
    super.key,
    required this.store,
    required this.onDurationChanged,
  });

  @override
  State<DurationInputWidget> createState() => _DurationInputWidgetState();
}

class _DurationInputWidgetState extends State<DurationInputWidget> {
  @override
  void initState() {
    widget.store.init();
    setupReactions();
    super.initState();
  }

  ReactionDisposer? reactionDisposer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Observer(
          builder: (_) => Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  widget.store.updateHours(int.tryParse(value) ?? 0),
              decoration: const InputDecoration(labelText: 'Hours'),
            ),
          ),
        ),
        const Gap(4),
        const Text(' : ', style: TextStyles.labelText),
        const Gap(4),
        Observer(
          builder: (_) => Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  widget.store.updateMinutes(int.tryParse(value) ?? 0),
              decoration: const InputDecoration(labelText: 'Minutes'),
            ),
          ),
        ),
        const Gap(4),
        const Text(': ', style: TextStyles.labelText),
        const Gap(4),
        Observer(
          builder: (_) => Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  widget.store.updateSeconds(int.tryParse(value) ?? 0),
              decoration: const InputDecoration(labelText: 'Seconds'),
            ),
          ),
        ),
      ],
    );
  }

  void setupReactions() {
    reactionDisposer ??=
        reaction((_) => widget.store.totalDuration, (Duration newValue) {
      widget.onDurationChanged(newValue);
    });
  }

  @override
  void dispose() {
    reactionDisposer?.call();
    reactionDisposer = null;
    super.dispose();
  }
}
