import 'package:flutter/material.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/add_ons.dart';

class AddOnsSelection extends StatelessWidget {
  final Set<AddOns> selectedAddOns;
  final ValueChanged<AddOns> onAddOnToggled;

  const AddOnsSelection({
    super.key,
    required this.selectedAddOns,
    required this.onAddOnToggled,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Wrap(
        spacing: 12.0,
        runSpacing: 10.0,
        alignment: WrapAlignment.center,
        children: AddOns.values.map((addon) {
          final bool isSelected = selectedAddOns.contains(addon);

          return FilterChip(
            avatar: Icon(
              addon.icon,
              size: 16,
              color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
            ),
            label: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  addon.label,
                  style: TextStyle(
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                Text(
                  addon.priceTag,
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected
                        ? colorScheme.onPrimary.withValues(alpha: 0.8)
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            selected: isSelected,
            onSelected: (_) => onAddOnToggled(addon),
            selectedColor: colorScheme.primary,
            backgroundColor: colorScheme.surfaceContainerHigh,
            showCheckmark: false,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(
              color: isSelected ? Colors.transparent : Colors.transparent,
              width: 1,
            ),
            pressElevation: 0,
          );
        }).toList(),
      ),
    );
  }
}
