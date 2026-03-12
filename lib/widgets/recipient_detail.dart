import 'package:advmobprog_midterms_tp03_amarille/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';

class RecipientDetail extends StatelessWidget {
  const RecipientDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBoxWidget(labelText: "Recipient Name", hintText: "Sarah Jenkins"),
        SizedBox(height: 8),
        TextBoxWidget(labelText: "Dedication", hintText: "Happy Birthday!"),
        SizedBox(height: 8),
        TextBoxWidget(
          labelText: "Delivery Address",
          hintText: "123 Streets, City",
        ),
      ],
    );
  }
}
