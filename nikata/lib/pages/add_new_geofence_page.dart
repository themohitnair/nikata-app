import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class AddNewGeofenceForm extends StatelessWidget {
  const AddNewGeofenceForm({super.key});

  bool isValidGeofenceName(String? geoname) {
    return ((geoname != null) && (geoname == '') && (geoname.length > 30));
  }

  bool isValidGeofenceRadius(String radius) {
    int? rad = int.tryParse(radius);
    if (rad == null) {
      return false;
    }
    return (rad < 3214);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (!isValidGeofenceName(value)) {
                      return 'Geofence name must be less than 30 characters in length and must not be left empty';
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
                        color: Colors.yellow
                      )
                    ),
                    border: OutlineInputBorder(
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
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Radius',
                    hintStyle: TextStyle(
                      color: Colors.green,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow
                      )
                    ),
                    border: OutlineInputBorder(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}