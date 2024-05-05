import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.yellow
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.black,
          title: SvgPicture.asset(
            'assets/images/logo.svg',
            fit: BoxFit.contain,
            height: 25,
          )
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

              ListTile(
                leading: Icon(
                  Icons.person_2_sharp,
                  color: Colors.yellow
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontFamily: 'FiraCode'
                  )
                )
              ),

              ListTile(
                leading: Icon(
                  Icons.info_sharp,
                  color: Colors.yellow
                ),
                title: Text(
                  "About",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontFamily: 'FiraCode'
                  )
                )
              ),

              ListTile(
                leading: Icon(
                  Icons.message_sharp,
                  color: Colors.yellow
                ),
                title: Text(
                  "Informed",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontFamily: 'FiraCode'
                  )
                )
              )


              
            ],
          )
        ),
      ),
    );
  }
}