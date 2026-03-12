enum CakeSize {
  small("Small", 0.8),
  medium("Medium", 1.0),
  large("Large", 1.25);

  final String label;
  final double priceMultiplier;

  const CakeSize(this.label, this.priceMultiplier);

  String get relativePriceLabel {
    if (priceMultiplier == 1.0) return "Base";

    final double diff = (priceMultiplier - 1.0) * 100;
    final int percent = diff.round();

    return percent > 0 ? "+$percent%" : "$percent%";
  }
}
