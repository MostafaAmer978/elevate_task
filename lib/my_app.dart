import 'package:elevate_task/features/screen_products/presentation_layer/pages/screen_products.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: ScreenProducts(),
    );
  }
}
