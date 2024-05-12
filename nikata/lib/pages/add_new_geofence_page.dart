import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return ((rad != null) && (rad < 321400));
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data
      String geoname = _geonameController.text;
      String radius = _radiusController.text;
      // You can handle form submission here, e.g., save data to database
      // Reset text controllers after submission if needed
      _geonameController.clear();
      _radiusController.clear();
      // Show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Geofence added successfully!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                decoration: InputDecoration(
                  hintText: 'Geofence Name',
                  hintStyle: TextStyle(
                    color: Colors.green,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.yellow
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.yellow,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red
                    )
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
              SizedBox(height: 10), // Add spacing between fields
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.yellow
                    )
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red
                    )
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
              SizedBox(height: 10),
              Flexible(
                flex: 2,
                child: Container(
                  height: 400,
                  child: SelectorMap(
                    radiusController: _radiusController,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.yellow,
                  ),
                  onPressed: () {
                    _submitForm(context);
                  },
                  child: Text('Add Geofence'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}