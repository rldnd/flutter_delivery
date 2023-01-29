import 'package:delivery/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? errorText;
  final String hintText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    required this.onChanged,
    super.key,
    this.errorText,
    this.hintText = '입력해주세요',
    this.obscureText = false,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: C_INPUT_BORDER,
        width: 1.0,
      ),
    );

    return TextFormField(
      cursorColor: C_PRIMARY,
      onChanged: onChanged,
      autofocus: autofocus,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20.0),
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: C_BODY_TEXT,
          fontSize: 14.0,
        ),
        fillColor: C_INPUT_BG,
        filled: true,
        border: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: C_PRIMARY,
          ),
        ),
      ),
    );
  }
}
