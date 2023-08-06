import 'package:flutter/material.dart';
import 'package:pokedex_app/screens/home_screen.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 158, 9, 34),
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 31, 31, 31),
);

final ThemeData darkPokeTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  colorScheme: kDarkColorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: kDarkColorScheme.onPrimaryContainer,
    foregroundColor: kDarkColorScheme.primaryContainer,
  ),
  cardTheme: CardTheme(
    color: kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.primaryContainer,
      foregroundColor: kDarkColorScheme.onPrimaryContainer,
    ),
  ),
  textTheme: ThemeData().textTheme.copyWith(
        headline1: TextStyle(
          fontWeight: FontWeight.bold,
          color: kDarkColorScheme.onSecondaryContainer,
          fontSize: 17,
        ),
      ),
);

final ThemeData lightPokeTheme = ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: kColorScheme,
  scaffoldBackgroundColor: kColorScheme.inversePrimary,
  appBarTheme: AppBarTheme(
    backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer,
  ),
  cardTheme: CardTheme(
    color: kColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primaryContainer,
    ),
  ),
  textTheme: ThemeData().textTheme.copyWith(
        headline1: TextStyle(
          fontWeight: FontWeight.bold,
          color: kColorScheme.onSecondaryContainer,
          fontSize: 17,
        ),
      ),
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: darkPokeTheme,
      theme: lightPokeTheme,
      home: HomeScreen(),
    );
  }
}
