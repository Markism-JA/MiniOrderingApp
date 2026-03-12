import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum AddOns {
  candles(LucideIcons.flame, "Candles", 20),
  sparklers(LucideIcons.sparkles, "Sparklers", 20),
  birthdayTopper(LucideIcons.star, "Birthday Topper", 25);

  final IconData icon;
  final String label;
  final double price;

  const AddOns(this.icon, this.label, this.price);

  String get priceTag => "+₱${price.toStringAsFixed(0)}";
}
