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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 280,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
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
