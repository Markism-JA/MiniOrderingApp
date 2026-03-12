import 'package:advmobprog_midterms_tp03_amarille/model/cake.dart';
import 'package:flutter/material.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/cake_card.dart';

class CakeGroup extends StatefulWidget {
  final List<Cake> cakes;
  final ValueChanged<Cake?> onSelectionChanged;

  const CakeGroup({
    super.key,
    required this.cakes,
    required this.onSelectionChanged,
  });

  @override
  State<CakeGroup> createState() => _CakeGroupState();
}

class _CakeGroupState extends State<CakeGroup> {
  String? _selectedCakeId;

  double _calculateAspectRatio(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 360) return 0.70;
    if (width < 400) return 0.80;
    return 0.90;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: _calculateAspectRatio(context),
      ),
      itemCount: widget.cakes.length,
      itemBuilder: (context, index) {
        final cake = widget.cakes[index];
        return CakeCard(
          cake: cake,
          isSelected: _selectedCakeId == cake.id,
          onTap: () {
            setState(() => _selectedCakeId = cake.id);
            widget.onSelectionChanged(cake);
          },
        );
      },
    );
  }
}
