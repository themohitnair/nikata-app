import 'package:flutter/material.dart';
import 'package:nikata/pages/essentials.dart';

class InformedPage extends StatelessWidget {
  const InformedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sidePageAppBar(
        title: 'Informed'
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}