import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const _themeKey = "theme_preference";

  /// Save the theme preference (light or dark).
  Future<void> saveThemePreference(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  /// Retrieve the saved theme preference.
  Future<String> getThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? "light"; // Default to "light".
  }
}
