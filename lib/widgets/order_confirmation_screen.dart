import 'package:flutter/material.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/order.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Order order;
  final VoidCallback onConfirm;

  const OrderConfirmationScreen({
    super.key,
    required this.order,
    required this.onConfirm,
  });

  String _formatDate(DateTime date) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return "${months[date.month - 1]} ${date.day}, ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isWideScreen = MediaQuery.of(context).size.width > 700;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        centerTitle: true,
        title: const Text(
          "Confirm Order",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      bottomNavigationBar: isWideScreen ? null : _buildStickyButton(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 24),

                _buildSectionTitle(context, "Delivery Details"),
                _buildDeliveryInfoCard(colorScheme),

                _buildSectionTitle(context, "Item Summary"),
                _buildOrderDetailCard(colorScheme),
                const SizedBox(height: 24),

                _buildPriceBreakdown(colorScheme),
                const SizedBox(height: 32),

                if (isWideScreen) _buildConfirmButton(),

                Center(
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: const Text("Edit Order"),
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryInfoCard(ColorScheme colorScheme) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _infoRow(
              Icons.person_outline,
              "Recipient",
              order.recipient,
              colorScheme,
            ),
            const Divider(height: 24),
            _infoRow(
              Icons.location_on_outlined,
              "Address",
              order.deliveryAddress,
              colorScheme,
            ),
            const Divider(height: 24),
            _infoRow(
              Icons.calendar_today_outlined,
              "Delivery Date",
              _formatDate(order.deliveryDay),
              colorScheme,
            ),const Divider(height: 24),
            _infoRow(
              Icons.info_outline,
              "Delivery Instruction",
              order.deliveryInstruction.isEmpty ? "No instructions" : order.deliveryInstruction,
              colorScheme,
            ),

            if (order.dedication.isNotEmpty) ...[
              const Divider(height: 24),
              _infoRow(
                Icons.card_giftcard_outlined,
                "Dedication",
                "\"${order.dedication}\"",
                colorScheme,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value,
    ColorScheme colorScheme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: colorScheme.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 4),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStickyButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: _buildConfirmButton(),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: FilledButton(
        onPressed: onConfirm,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          "Confirm & Pay",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildOrderDetailCard(ColorScheme colorScheme) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                order.cake.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.cake.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Size: ${order.size.label} (${order.size.relativePriceLabel})",
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (order.addOns.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      "Add-ons: ${order.addOns.map((e) => e.label).join(', ')}",
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              "₱${(order.cake.price * order.size.priceMultiplier).toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown(ColorScheme colorScheme) {
    double subtotal = order.cake.price * order.size.priceMultiplier;
    double addOnTotal = order.addOns.fold(0, (sum, item) => sum + item.price);

    return Column(
      children: [
        _priceRow("Subtotal", "₱${subtotal.toStringAsFixed(0)}", colorScheme),
        if (order.addOns.isNotEmpty)
          _priceRow(
            "Add-ons",
            "₱${addOnTotal.toStringAsFixed(0)}",
            colorScheme,
          ),
        _priceRow("Payment Method", order.paymentOption.label, colorScheme),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Price",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "₱${order.total.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _priceRow(String label, String value, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: colorScheme.onSurfaceVariant)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
