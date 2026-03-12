import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum PaymentOption {
  cash(LucideIcons.banknote, "Cash"),
  gCash(LucideIcons.smartphone, "GCash"),
  card(LucideIcons.creditCard, "Card");

  final IconData icon;
  final String label;

  const PaymentOption(this.icon, this.label);
}
