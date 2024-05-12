import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

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

class customTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;

  const customTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
  }) : super(key: key);

  @override
  State<customTextField> createState() => _customTextFieldState();
}

class _customTextFieldState extends State<customTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        autocorrect: false,
        cursorColor: Colors.yellow,
        style: TextStyle(
          color: Colors.yellow,
          fontFamily: 'FiraCode',
        ),
        controller: widget.controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: Colors.green,
            fontFamily: 'FiraCode',
            letterSpacing: -0.5,
          ),
          labelText: widget.labelText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.yellow
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.red),
          ),
          floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelStyle: TextStyle(
            color: Colors.yellow,
          ),
          errorStyle: TextStyle(
            color: Colors.red,
            fontFamily: 'FiraCode',
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}


class SelectorMap extends StatefulWidget {
  const SelectorMap({super.key, required this.radiusController});
  final TextEditingController radiusController;

  @override
  State<SelectorMap> createState() => _SelectorMapState();
}

class _SelectorMapState extends State<SelectorMap> {
  LatLng _userLocation = LatLng(0, 0);
  LatLng _selectedLocation = LatLng(0, 0);
  late MapController _mapController = MapController();
  Timer? _locationTimer;

  @override
  void initState() {
    super.initState();
    _getUserLocation().then((_) {
      _mapController.move(_userLocation, 15.0);
      _startLocationUpdates();
      _selectedLocation = _userLocation;  // Initialize _selectedLocation
    });
  }

  @override
  void dispose() {
    super.dispose();
    _locationTimer?.cancel();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Handle case when user denies location permission
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
    } on PlatformException catch (e) {
      // Handle platform exceptions
      print("Error: ${e.message}");
    }
  }

  void _startLocationUpdates() {
    _locationTimer = Timer.periodic(Duration(seconds: 10), (_) async {
      await _getUserLocation();
    });
  }


  @override
  Widget build(BuildContext context) {
    double radius = double.tryParse(widget.radiusController.text) ?? 0.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _userLocation,
          initialZoom: 15,
          onTap: (tapPosition, point) {
            setState(() {
              _selectedLocation = LatLng(point.latitude, point.longitude); 
            });
          },
        ),
        children: [
          
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _userLocation, 
                child: Icon(
                  Icons.location_searching_sharp,
                  color: Colors.purple
                )
              ),
              Marker(
                point: _selectedLocation,
                child: Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 10
                )
              )
            ]
          ),
          CircleLayer(
            circles: [
              CircleMarker(
                point: _selectedLocation, 
                radius: radius,
                color: Colors.transparent,
                borderColor: Colors.red[200] ?? Colors.blue,
                borderStrokeWidth: 2,
                useRadiusInMeter: true
              )
            ]
          )

        ],
      )
    );
  }
}