import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum AddOns {
  candles(LucideIcons.flame, "Candles"),
  sparklers(LucideIcons.sparkles, "Sparklers"),
  birthdayTopper(LucideIcons.star, "Birthday Topper");

  final IconData icon;
  final String label;

  const AddOns(this.icon, this.label);
}
