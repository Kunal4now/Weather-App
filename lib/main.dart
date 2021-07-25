import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weatherapp/cityScreen.dart';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentCity = "Gwalior";
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?q=$currentCity&units=metric&appid=f106253b26e32f080dfcd9860b7164e6");
    var results = jsonDecode(response.body);
    this.temp = results['main']['temp'];
    this.description = results['weather'][0]['description'];
    this.currently = results['weather'][0]['main'];
    this.humidity = results['main']['humidity'];
    this.windSpeed = results['wind']['speed'];
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1601297183305-6df142704ea2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in $currentCity",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temprature"),
                    trailing: Text(
                        temp != null ? temp.toString() + "\u00B0" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null
                        ? description.toString()
                        : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(
                        windSpeed != null ? windSpeed.toString() : "Loading"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("City"),
        onPressed: () async {
          var typedCity = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return CityScreen();
          }));
          print(typedCity);
          setState(() {
            currentCity = typedCity;
            getWeather();
          });
        },
        icon: const FaIcon(FontAwesomeIcons.city),
        backgroundColor: Colors.red,
      ),
    );
  }
}
