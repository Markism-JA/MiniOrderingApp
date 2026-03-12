import 'package:advmobprog_midterms_tp03_amarille/model/add_ons.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/cake.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/cake_size.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/payment_option.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/addons_selection.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/cake_group.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/cake_size_selection.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/delivery_day_picker.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/payment_options_selection.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/recipient_detail.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const CakeApp(),
    ),
  );
}

class CakeApp extends StatefulWidget {
  const CakeApp({super.key});

  @override
  State<CakeApp> createState() => _CakeAppState();
}

class _CakeAppState extends State<CakeApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  static const _defaultCustomColor = Color(0xFF64412c);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme = ColorScheme.fromSeed(
          seedColor: _defaultCustomColor,
          brightness: Brightness.light,
        );

        ColorScheme darkScheme = ColorScheme.fromSeed(
          seedColor: _defaultCustomColor,
          brightness: Brightness.dark,
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: _themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightDynamic?.harmonized() ?? lightScheme,
            textTheme: GoogleFonts.openSansTextTheme(),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkDynamic?.harmonized() ?? darkScheme,
            textTheme: GoogleFonts.openSansTextTheme(
              ThemeData(brightness: Brightness.dark).textTheme,
            ),
          ),
          home: OrderFormScreen(onThemeToggle: toggleTheme),
        );
      },
    );
  }
}

class OrderFormScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const OrderFormScreen({super.key, required this.onThemeToggle});

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  Cake? _selectedCake;
  CakeSize _cakeSize = CakeSize.medium;
  DateTime _selectedDeliveryDate = DateTime.now();
  PaymentOption _selectedPayment = PaymentOption.cash;
  Set<AddOns> _selectedAddOns = {};

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dedicationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  static const List<Cake> cakeList = [
    Cake(
      id: "1",
      name: "Chocolate Fudge",
      description: "Rich cocoa layers with silky ganache.",
      imagePath: "assets/choco.png",
    ),
    Cake(
      id: "2",
      name: "Red Velvet",
      description: "Crimson sponge and tangy cream cheese.",
      imagePath: "assets/red_velvet.png",
    ),
    Cake(
      id: "3",
      name: "Vanilla Bean",
      description: "Light sponge with aromatic vanilla flecks.",
      imagePath: "assets/vanilla_bean.png",
    ),
    Cake(
      id: "4",
      name: "Strawberry",
      description: "Sweet strawberry sponge with fresh fruit.",
      imagePath: "assets/strawberry.png",
    ),
    Cake(
      id: "5",
      name: "Maple Brown Pecan",
      description: "Toasty butterscotch notes and crunchy pecans.",
      imagePath: "assets/maple_brown.png",
    ),
    Cake(
      id: "6",
      name: "Spiced Black Forest",
      description: "Chai-spiced layers with tart cherries.",
      imagePath: "assets/spiced_black_forest.png",
    ),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _dedicationController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleAddOn(AddOns addon) {
    setState(() {
      if (_selectedAddOns.contains(addon)) {
        _selectedAddOns.remove(addon);
      } else {
        _selectedAddOns.add(addon);
      }
    });
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _dedicationController.clear();
      _addressController.clear();
      _selectedCake = null;
      _cakeSize = CakeSize.medium;
      _selectedDeliveryDate = DateTime.now();
      _selectedPayment = PaymentOption.cash;
      _selectedAddOns.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Order form has been reset."),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _placeOrder() {
    // Basic Validation
    if (_nameController.text.trim().isEmpty || _selectedCake == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Please select a cake and enter the recipient's name.",
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Success Dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Order Confirmed! \uD83C\uDF89"),
        content: Text(
          "Your ${_cakeSize.label} ${_selectedCake?.name} will be delivered on "
          "${_selectedDeliveryDate.month}/${_selectedDeliveryDate.day} using ${_selectedPayment.label}.\n\n"
          "Thank you for your order!",
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _resetForm(); // Clear form for the next order
            },
            child: const Text("Awesome"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        title: const Text(
          "Order Your Cake",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: Icon(isDark ? Icons.cake : Icons.cake_outlined),
          ),
          const SizedBox(width: 20),
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: SizedBox(
            height: 56,
            child: FilledButton(
              onPressed: _placeOrder,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Place Order",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          children: [
            RecipientDetail(
              nameController: _nameController,
              dedicationController: _dedicationController,
              addressController: _addressController,
            ),
            const SizedBox(height: 24),

            _buildSectionHeader(context, "Select your Cake"),
            CakeGroup(
              cakes: cakeList,
              onSelectionChanged: (cake) {
                setState(() {
                  _selectedCake = cake;
                });
              },
            ),
            const SizedBox(height: 24),

            _buildSectionHeader(context, "Size"),
            Center(
              child: CakeSizeSelection(
                selectedSize: _cakeSize,
                onSizeChanged: (newSize) {
                  setState(() {
                    _cakeSize = newSize;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader(context, "Delivery Day"),
            DeliveryDayPicker(
              selectedDate: _selectedDeliveryDate,
              onDateSelected: (newDate) {
                setState(() {
                  _selectedDeliveryDate = newDate;
                });
              },
            ),
            const SizedBox(height: 24),

            _buildSectionHeader(context, "Payment Options"),
            PaymentSelection(
              selectedOption: _selectedPayment,
              onOptionChanged: (newOption) {
                setState(() {
                  _selectedPayment = newOption;
                });
              },
            ),
            const SizedBox(height: 24),

            _buildSectionHeader(context, "Add-ons"),
            AddOnsSelection(
              selectedAddOns: _selectedAddOns,
              onAddOnToggled: _toggleAddOn,
            ),

            const SizedBox(height: 40),

            Center(
              child: TextButton.icon(
                onPressed: _resetForm,
                icon: const Icon(Icons.refresh, size: 20),
                label: const Text("Reset Form"),
                style: TextButton.styleFrom(foregroundColor: colorScheme.error),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
