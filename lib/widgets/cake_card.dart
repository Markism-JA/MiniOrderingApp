import 'package:advmobprog_midterms_tp03_amarille/model/cake.dart';
import 'package:flutter/material.dart';

class CakeCard extends StatelessWidget {
  final Cake cake;
  final String? selectedCakeId;
  final ValueChanged<String?> onSelected;

  const CakeCard({
    super.key,
    required this.cake,
    required this.selectedCakeId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = selectedCakeId == cake.id;

    return GestureDetector(
      onTap: () => onSelected(cake.id),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed height image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                cake.imagePath,
                height: 110, // Slightly reduced to save space
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cake.name,
                      maxLines: 1, // Keep name to one line to save space
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cake.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),

                    // Pushes the radio button to the absolute bottom
                    const Spacer(),

                    Center(
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.outline,
                            width: 2,
                          ),
                          color: isSelected
                              ? colorScheme.primary
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                size: 16,
                                color: colorScheme.onPrimary,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
