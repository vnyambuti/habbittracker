import 'package:flutter/material.dart';
import 'package:habbittrack/Theme/theme_provider.dart';
import 'package:habbittrack/database/habbit_database.dart';
import 'package:habbittrack/pages/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Habbitdatabase.initialize();
  await Habbitdatabase.saveFirstLaunchDate();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => Habbitdatabase(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
