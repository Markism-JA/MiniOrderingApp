import 'package:advmobprog_midterms_tp03_amarille/model/cake_size.dart';
import 'package:flutter/material.dart';

class CakeSizeSelection extends StatelessWidget {
  final CakeSize selectedSize;
  final ValueChanged<CakeSize> onSizeChanged;

  const CakeSizeSelection({
    super.key,
    required this.selectedSize,
    required this.onSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 12.0,
      alignment: WrapAlignment.center,
      children: CakeSize.values.map((size) {
        final bool isSelected = selectedSize == size;

        return ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(
              size.label,
              style: TextStyle(
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            if (selected) {
              onSizeChanged(size);
            }
          },
          selectedColor: colorScheme.primary,
          backgroundColor: colorScheme.surfaceContainerHigh,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide.none,
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}
