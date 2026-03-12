import 'package:flutter/material.dart';

class TextBoxWidget extends StatelessWidget {
  final String labelText;
  final String hintText;

  const TextBoxWidget({
    super.key,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: colorScheme.onSurface.withValues(alpha: 0.4),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),

          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
