import 'package:flutter/material.dart';
import 'package:nikata/pages/essentials.dart';

class AddNewGeofenceForm extends StatelessWidget {
  AddNewGeofenceForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _geonameController = TextEditingController();
  final _radiusController = TextEditingController();

  bool isValidGeofenceName(String? geoname) {
    return geoname != null && geoname.isNotEmpty && geoname.length <= 30;
  }

  bool isValidGeofenceRadius(String radius) {
    int? rad = int.tryParse(radius);
    return rad != null && rad < 3214;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _geonameController,
                      validator: (value) {
                        if (!isValidGeofenceName(value)) {
                          return 'Geofence name must be less than 30 characters and not empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Geofence Name',
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.yellow,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'FiraCode',
                        color: Colors.yellow,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _radiusController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (!isValidGeofenceRadius(value ?? '')) {
                          return 'Invalid radius';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Radius',
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.yellow,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'FiraCode',
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 450,
                child: SelectorMap(
                  radiusController: _radiusController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
