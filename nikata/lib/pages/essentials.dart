import 'package:flutter/material.dart';
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
  final TextEditingController radiusController;

  const SelectorMap({Key? key, required this.radiusController}) : super(key: key);

  @override
  _SelectorMapState createState() => _SelectorMapState();
}

class _SelectorMapState extends State<SelectorMap> {
  final MapController _mapController = MapController();
  LatLng _selectedCoordinates = LatLng(0, 0);
  LatLng _userLocation = LatLng(0, 0);
  late Timer _locationUpdateTimer;

  @override
  void initState() {
    super.initState();
    _checkLocationServiceAndPermission();
    _startLocationUpdates();
  }

  @override
  void dispose() {
    _locationUpdateTimer.cancel();
    super.dispose();
  }

  Future<void> _checkLocationServiceAndPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceDialog();
    } else {
      _requestLocationPermission();
    }
  }

  Future<void> _requestLocationPermission() async {
    final PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      _getCurrentLocation();
    } else {
      print('Location permission denied');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true,
      );

      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
        _selectedCoordinates = _userLocation;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _setMapCenter(LatLng center) {
    _mapController.move(center, 13.0);
  }

  void _startLocationUpdates() {
    const updateInterval = Duration(seconds: 10); // Define the interval for location updates
    _locationUpdateTimer = Timer.periodic(updateInterval, (Timer timer) {
      _getCurrentLocation(); // Fetch the user's current location periodically
    });
  }

  void _showLocationServiceDialog() {
    showDialog(
      barrierColor: Colors.grey[700],
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Location Service Disabled'),
        content: Text('Please enable location services to use this feature.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openLocationSettings();
            },
            child: Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double radius = double.tryParse(widget.radiusController.text) ?? 0.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Adjust the value to control the corner radius
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _selectedCoordinates,
          initialZoom: 13.0,
          onTap: (tapPosition, point) {
            setState(() {
              _selectedCoordinates = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          CircleLayer(
            circles: [
              CircleMarker(
                point: _selectedCoordinates,
                radius: radius,
                color: Colors.transparent,
                borderColor: Colors.blue,
                borderStrokeWidth: 2,
                useRadiusInMeter: true,
              )
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _selectedCoordinates,
                width: 50,
                height: 50,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              ),
              Marker(
                point: _userLocation,
                width: 40,
                height: 40,
                child: Icon(
                  Icons.person_pin,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
