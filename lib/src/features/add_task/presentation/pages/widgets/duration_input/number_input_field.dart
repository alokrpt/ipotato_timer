
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputField extends StatelessWidget {
  const NumberInputField({
    super.key,
    required this.onChanged,
    required this.value,
    required this.labelText,
  });

  final Function(String)? onChanged;
  final String value;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          textAlign: TextAlign.center,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d{0,2}$'),
              replacementString: value,
            )
          ],
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelText: labelText,
            hintText: '00',
            border: const OutlineInputBorder(),
          )),
    );
  }
}
