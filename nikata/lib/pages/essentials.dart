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

ListTile DrawerListTile(IconData icon, String title, Function() onTap, Color color) {
    return ListTile(
      leading: Icon(
        icon,
        color: color
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontFamily: 'FiraCode',
          letterSpacing: 0,
          fontWeight: FontWeight.bold
        )
      ),
      onTap: onTap,
    );
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