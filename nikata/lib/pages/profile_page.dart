import 'package:flutter/material.dart';
import 'package:nikata/pages/essentials.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sidePageAppBar(
        title: 'Profile'
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}