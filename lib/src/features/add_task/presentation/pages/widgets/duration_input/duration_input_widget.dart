import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../core/presentation/gap.dart';
import '../../../../../../core/presentation/text_styles.dart';
import 'duration_input_store.dart';
import 'number_input_field.dart';

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
    return Observer(
      builder: (_) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumberInputField(
              onChanged: (value) =>
                  widget.store.updateHours(int.tryParse(value) ?? 0),
              value: widget.store.hours.toString(),
              labelText: 'HH',
            ),
            const Gap(4),
            const Text(' : ', style: TextStyles.labelText),
            const Gap(4),
            NumberInputField(
              onChanged: (value) =>
                  widget.store.updateMinutes(int.tryParse(value) ?? 0),
              value: widget.store.minutes.toString(),
              labelText: 'MM',
            ),
            const Gap(4),
            const Text(': ', style: TextStyles.labelText),
            const Gap(4),
            NumberInputField(
              onChanged: (value) =>
                  widget.store.updateSeconds(int.tryParse(value) ?? 0),
              value: widget.store.seconds.toString(),
              labelText: 'SS',
            ),
          ],
        );
      },
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
