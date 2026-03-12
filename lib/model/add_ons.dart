import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum AddOns {
  candles(LucideIcons.flame),
  sparklers(LucideIcons.sparkles),
  birthdayTopper(LucideIcons.star);

  final IconData icon;

  const AddOns(this.icon);
}
