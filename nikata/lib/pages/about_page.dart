import 'package:flutter/material.dart';
import 'package:nikata/pages/essentials.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sidePageAppBar(
        title: 'About Nikata'
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}