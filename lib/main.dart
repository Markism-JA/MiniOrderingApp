import 'package:advmobprog_midterms_tp03_amarille/model/add_ons.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/cake.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/cake_size.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/payment_option.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/order.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/addons_selection.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/cake_group.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/cake_size_selection.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/delivery_day_picker.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/order_confirmation_screen.dart';
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
            colorScheme: lightScheme,
            textTheme: GoogleFonts.openSansTextTheme(),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkScheme,
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
  final Set<AddOns> _selectedAddOns = {};

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dedicationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  static const List<Cake> cakeList = [
    Cake(
      id: "1",
      name: "Chocolate Fudge",
      description: "Rich cocoa layers with silky ganache.",
      imagePath: "assets/choco.png",
      price: 950.0,
    ),
    Cake(
      id: "2",
      name: "Red Velvet",
      description: "Crimson sponge and tangy cream cheese.",
      imagePath: "assets/red_velvet.png",
      price: 1100.0,
    ),
    Cake(
      id: "3",
      name: "Vanilla Bean",
      description: "Light sponge with aromatic vanilla flecks.",
      imagePath: "assets/vanilla_bean.png",
      price: 850.0,
    ),
    Cake(
      id: "4",
      name: "Strawberry",
      description: "Sweet strawberry sponge with fresh fruit.",
      imagePath: "assets/strawberry.png",
      price: 1050.0,
    ),
    Cake(
      id: "5",
      name: "Maple Brown Pecan",
      description: "Toasty butterscotch notes and crunchy pecans.",
      imagePath: "assets/maple_brown.png",
      price: 1200.0,
    ),
    Cake(
      id: "6",
      name: "Spiced Black Forest",
      description: "Chai-spiced layers with tart cherries.",
      imagePath: "assets/spiced_black_forest.png",
      price: 1150.0,
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

  double get _currentPrice {
    if (_selectedCake == null) return 0.0;

    double total = _selectedCake!.price * _cakeSize.priceMultiplier;

    for (var addon in _selectedAddOns) {
      total += addon.price;
    }

    return total;
  }

  void _placeOrder() {
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

    final String generatedId =
        "ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";

    final newOrder = Order(
      id: generatedId,
      cake: _selectedCake!,
      size: _cakeSize,
      addOns: _selectedAddOns,
      paymentOption: _selectedPayment,
      total: _currentPrice,
      recipient: _nameController.text.trim(),
      deliveryAddress: _addressController.text.trim().isEmpty
          ? "No address provided"
          : _addressController.text.trim(),
      dedication: _dedicationController.text.trim(),
      deliveryDay: _selectedDeliveryDate,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderConfirmationScreen(
          order: newOrder,
          onConfirm: () {
            Navigator.pop(context);

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Order Successful!"),
                content: Text(
                  "Your ${_cakeSize.label} ${_selectedCake?.name} will be delivered on "
                  "${_selectedDeliveryDate.month}/${_selectedDeliveryDate.day}.\n\n"
                  "Thank you for ordering with us!",
                ),
                actions: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _resetForm();
                    },
                    child: const Text("Done"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 700;
    const double maxFormWidth = 650.0;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        centerTitle: isWideScreen,
        title: const Text(
          "Order Your Cake",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: Icon(isDark ? Icons.cake : Icons.cake_outlined),
          ),
          const SizedBox(width: 20),
        ],
      ),

      bottomNavigationBar: isWideScreen
          ? null
          : SafeArea(
              child: Container(
                color: colorScheme.surface,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLiveTotal(colorScheme),
                    _buildPlaceOrderButton(),
                  ],
                ),
              ),
            ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxFormWidth),
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
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

                if (isWideScreen) ...[
                  const Divider(),
                  _buildLiveTotal(colorScheme),
                  _buildPlaceOrderButton(),
                  const SizedBox(height: 20),
                ],

                Center(
                  child: TextButton.icon(
                    onPressed: _resetForm,
                    icon: const Icon(Icons.refresh, size: 20),
                    label: const Text("Reset Form"),
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.error,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLiveTotal(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Estimated Total",
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
          ),
          Text(
            "₱${_currentPrice.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: FilledButton(
        onPressed: _placeOrder,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          "Review Order",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
