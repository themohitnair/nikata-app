import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class sidePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  sidePageAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.yellow
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.black,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'FiraCode',
          color: Colors.yellow,
          letterSpacing: -2
        )
      )
    );
  }
}

class mainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;
  final double imageheight;
  mainPageAppBar({super.key, required this.color, required this.imageheight});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: color
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.black,
      title: SvgPicture.asset(
        'assets/images/logo.svg',
        fit: BoxFit.contain,
        height: imageheight,
      )
    );
  }
}

class NewGeofenceForm extends StatelessWidget {
  const NewGeofenceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
            child: Container(
              height: 175,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(20)
              ),
              
            ),
          ),
        ],
      )

    );
  }
}

class customTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const customTextField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        style: TextStyle(
          color: Colors.yellow,
          fontFamily: 'FiraCode',
        ),
        controller: controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: Colors.green,
            fontFamily: 'FiraCode',
            letterSpacing: -0.5,
          ),
          labelText: labelText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.yellow)
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.red)
          ),
          floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelStyle: TextStyle(
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
