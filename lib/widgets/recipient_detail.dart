import 'package:advmobprog_midterms_tp03_amarille/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';

class RecipientDetail extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController dedicationController;
  final TextEditingController addressController;
  final TextEditingController deliveryInstructionController;
  const RecipientDetail({
    super.key,
    required this.nameController,
    required this.dedicationController,
    required this.addressController,
    required this.deliveryInstructionController
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBoxWidget(
          labelText: "Recipient Name",
          hintText: "Sarah Jenkins",
          controller: nameController,
        ),
        SizedBox(height: 8),
        TextBoxWidget(
          labelText: "Dedication",
          hintText: "Happy Birthday!",
          controller: dedicationController,
        ),
        SizedBox(height: 8),
        TextBoxWidget(
          labelText: "Delivery Address",
          hintText: "123 Streets, City",
          controller: addressController,
        ),
        SizedBox(height: 8),
        TextBoxWidget(
          labelText: "Delivery Instruction",
          hintText: "Leave at front door",
          controller: deliveryInstructionController,
        ),
      ],
    );
  }
}
