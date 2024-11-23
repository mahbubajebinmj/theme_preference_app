import 'package:flutter/material.dart';
import 'theme_preference.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemePreference _themePreference;
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _themePreference = ThemePreference();
    _loadThemePreference();
  }

  /// Load the saved theme preference and apply it.
  void _loadThemePreference() async {
    String theme = await _themePreference.getThemePreference();
    setState(() {
      _themeMode = theme == "dark" ? ThemeMode.dark : ThemeMode.light;
    });
  }

  /// Toggle the theme and save the new preference.
  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      String theme = _themeMode == ThemeMode.dark ? "dark" : "light";
      _themePreference.saveThemePreference(theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Preference App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomePage(
        themeMode: _themeMode,
        toggleTheme: _toggleTheme,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final ThemeMode themeMode;
  final VoidCallback toggleTheme;

  const HomePage({
    Key? key,
    required this.themeMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Preference"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Current Theme: ${themeMode == ThemeMode.light ? "Light" : "Dark"}",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleTheme,
              child: Text(
                "Switch to ${themeMode == ThemeMode.light ? "Dark" : "Light"} Theme",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
