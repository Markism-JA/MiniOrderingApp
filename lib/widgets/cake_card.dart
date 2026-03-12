import 'package:advmobprog_midterms_tp03_amarille/model/cake.dart';
import 'package:flutter/material.dart';

class CakeCard extends StatelessWidget {
  final Cake cake;
  final bool isSelected;
  final VoidCallback onTap;

  const CakeCard({
    super.key,
    required this.cake,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final dynamicImageHeight = constraints.maxWidth * 0.50;

        final titleFontSize = (constraints.maxWidth * 0.085).clamp(12.0, 16.0);
        final descFontSize = (titleFontSize * 0.8).clamp(10.0, 13.0);

        return GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      cake.imagePath,
                      height: dynamicImageHeight,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cake.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize: titleFontSize,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Expanded(
                              child: Text(
                                cake.description,
                                maxLines: constraints.maxHeight < 180 ? 2 : 3,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: descFontSize,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 10),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? colorScheme.primary
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected
                                        ? colorScheme.primary
                                        : colorScheme.outline,
                                    width: 1.5,
                                  ),
                                ),
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        size: 12,
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

              IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
