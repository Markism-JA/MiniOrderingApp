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
      spacing: 16.0,
      alignment: WrapAlignment.center,
      children: CakeSize.values.map((size) {
        final bool isSelected = selectedSize == size;

        return ChoiceChip(
          label: Container(
            constraints: const BoxConstraints(minWidth: 60),
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  size.label,
                  style: TextStyle(
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  size.relativePriceLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected
                        ? FontWeight.w500
                        : FontWeight.normal,
                    color: isSelected
                        ? colorScheme.onPrimary.withValues(alpha: 0.9)
                        : colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            if (selected) onSizeChanged(size);
          },
          selectedColor: colorScheme.primary,
          backgroundColor: colorScheme.surfaceContainerHigh,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.transparent,
            width: 1,
          ),
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}
