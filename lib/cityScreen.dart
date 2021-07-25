import 'package:flutter/material.dart';

class CityScreen extends StatelessWidget {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextField(
                  onChanged: (value) {
                    cityName = value;
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                    hintText: 'Enter City Name',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("City"),
        onPressed: () {
          Navigator.pop(context, cityName);
        },
        icon: const Icon(Icons.done),
        backgroundColor: Colors.red,
      ),
    );
  }
}
