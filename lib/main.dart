import 'package:advmobprog_midterms_tp03_amarille/model/cake.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/cake_size.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/cake_group.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/cake_size_selection.dart';
import 'package:advmobprog_midterms_tp03_amarille/widgets/recipient_detail.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => CakeApp()),
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
            textTheme: GoogleFonts.openSansTextTheme(),
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
  DateTime? _deliveryDate;

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          const SizedBox(width: 30),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            RecipientDetail(
              nameController: _nameController,
              dedicationController: _dedicationController,
              addressController: _addressController,
            ),
            const SizedBox(height: 16),
            Text(
              "Select your Cake",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CakeGroup(
              cakes: cakeList,
              onSelectionChanged: (cake) {
                print("Selected: ${cake?.name}");
                setState(() {
                  _selectedCake = cake;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              "Size",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }
}
