import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nikata/pages/about_page.dart';
import 'package:nikata/pages/add_new_geofence_page.dart';
import 'package:nikata/pages/essentials.dart';
import 'package:nikata/pages/geofences_page.dart';
import 'package:nikata/pages/informed_page.dart';
import 'package:nikata/pages/logout_page.dart';
import 'package:nikata/pages/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigateTo(Widget page) {
    Navigator.push(
      _scaffoldKey.currentContext!,
      MaterialPageRoute(builder: (context) => page)
    );
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

  int _selectedIndex = 0;

  final List _pages = [
    GeofencesPage() ,
    AddNewGeofenceForm()
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/about': (context) => AboutPage(),
        '/profile': (context) => ProfilePage(),
        '/informed': (context) => InformedPage(),
        '/logout': (context) => LogoutPage(),
      },
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[900],
      
        appBar: mainPageAppBar(
          color: Colors.yellow,
          imageheight: 25,
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey[900],
          child: Column(
            children: [

              DrawerHeader(
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  height: 50
                ),                
              ),

              DrawerListTile(Icons.info_sharp, 'About', () => _navigateTo(AboutPage()), Colors.yellow),
              DrawerListTile(Icons.person_2_sharp, 'Profile', () => _navigateTo(ProfilePage()), Colors.yellow),
              DrawerListTile(Icons.message_sharp, 'Informed', () => _navigateTo(InformedPage()), Colors.yellow),
              DrawerListTile(Icons.logout_sharp, 'Log out', () => _navigateTo(LogoutPage()), Colors.yellow),

                            
            ],
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          backgroundColor: Colors.black,
          showSelectedLabels: true,
          iconSize: 30,
          fixedColor: Colors.yellow,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 13
          ),
          unselectedLabelStyle: const TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.normal,
            fontSize: 11
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.explore_sharp,
                color: Colors.yellow
              ),
              label: 'Your Geofences'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_location_sharp,
                color: Colors.yellow
              ),
              label: 'Add Geofence'
            )
          ],
        ),
        body: _pages[_selectedIndex]
      ),
    );
  }
}