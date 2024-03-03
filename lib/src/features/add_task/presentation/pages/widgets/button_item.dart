import 'package:flutter/material.dart';

import '../../../../../core/presentation/text_styles.dart';

class ButtonItem extends StatelessWidget {
  const ButtonItem({
    super.key,
    required this.onTap,
    required this.text,
    this.borderRadius,
  });

  final Function() onTap;
  final String text;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 208, 205, 255),
          borderRadius: borderRadius ??
              const BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
        ),
        child: Align(
          child: Text(
            text,
            style: TextStyles.actionText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
