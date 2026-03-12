import 'package:advmobprog_midterms_tp03_amarille/widgets/recipient_detail.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => CakeApp()),
  );
}

class CakeApp extends StatefulWidget {
  const CakeApp({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        title: const Text("Order Your Cake"),
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
          children: const [RecipientDetail()],
        ),
      ),
    );
  }
}
