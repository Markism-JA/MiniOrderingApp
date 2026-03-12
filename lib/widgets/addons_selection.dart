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
        spacing: 10.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: AddOns.values.map((addon) {
          final bool isSelected = selectedAddOns.contains(addon);

          return FilterChip(
            avatar: Icon(
              addon.icon,
              size: 16,
              color: isSelected
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
            ),
            label: Text(
              addon.label,
              style: TextStyle(
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 13,
              ),
            ),
            selected: isSelected,
            onSelected: (_) => onAddOnToggled(addon),
            selectedColor: colorScheme.primary,
            backgroundColor: colorScheme.surfaceContainerHigh,
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            side: BorderSide.none,
            pressElevation: 0,
          );
        }).toList(),
      ),
    );
  }
}
