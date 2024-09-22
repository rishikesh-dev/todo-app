import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initializing hive to application
  await Hive.initFlutter();

  //Creating new box
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        scaffoldBackgroundColor: Colors.yellow[300],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.yellow[500],
        ),
        useMaterial3: true,
      ),
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
