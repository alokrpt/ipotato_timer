import 'package:flutter/material.dart';

import '../../../../../core/presentation/gap.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 120,
          right: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'No timers active. \nPress here to start a new one',
            ),
            const Gap(10),
            Image.asset(
              'assets/images/down_arrow.png',
              height: 100,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
