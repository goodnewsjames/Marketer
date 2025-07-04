import 'package:flutter/material.dart';
import 'package:marketer/screens/home_page.dart';

class Marketer extends StatelessWidget {
  const Marketer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

