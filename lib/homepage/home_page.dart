import 'dart:convert';
import 'dart:math';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:weatherapp/seven_days/nextdays.dart';
import 'package:weatherapp/provider/ThemeProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String weatherData = "";
  final String apiKey = "TjbLz73khW30gLV4XsFx1gnqSvN4k8Bm";
  String locationMessage = "";
  String country = "";
  String city = "";
  String firstTime = "";
  double? firstTemperatureApparent;
  num? firstTemperature;
  num? firstRainIntensity;
  int? firstPrecipitationProbability;
  DateTime currentDate = DateTime.now();
  late int? roundedTemp = 0;
  late int? roundedapTemp = 0;
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    // checkAndToggleTheme();
  }

  void checkAndToggleTheme() {
    final hour = DateTime.now().hour;
    if (hour >= 18 || hour < 6) {
      // Si l'heure est entre 20h et 6h, basculer vers le thème sombre
      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
    }
  }

  void getCurrentLocation() async {
    bool isLocationPermissionGranted = await _checkLocationPermission();

    if (isLocationPermissionGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        // Get country and city names using reverse geocoding
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        setState(() {
          locationMessage =
              "Latitude: ${position.latitude}, Longitude: ${position.longitude}";

          country = placemarks.first.country ?? "";
          city = placemarks.first.locality ?? "";
        });

        getWeatherData(position.latitude, position.longitude);
      } catch (e) {
        setState(() {
          locationMessage = "Error getting location";
          country = "";
          city = "";
          weatherData = "";
        });
      }
    } else {
      // Handle case where user denied location permission
      setState(() {
        locationMessage = "Location permission denied";
        country = "";
        city = "";
        weatherData = "";
      });
    }
  }

  List<double> generateRandomValues(int count, double excludedIndex) {
    Random random = Random();
    List<double> values = List.generate(count, (index) {
      if (index == excludedIndex) {
        return 100.0; // Fixed value for 4PM
      } else {
        return random.nextDouble() * 200.0 +
            50.0; // Random value between 50 and 250
      }
    });
    return values;
  }

  Future<bool> _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }

  void getWeatherData(double latitude, double longitude) async {
    String apiUrl =
        //  "https://api.tomorrow.io/v4/timelines?location=$latitude,$longitude&fields=temperature_2m,weatherCode&apikey=$apiKey";
        "https://api.tomorrow.io/v4/weather/forecast?location=$latitude,$longitude&apikey=$apiKey";
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      List<Map<String, dynamic>> weatherData = [];

      for (var minuteData in data["timelines"]["minutely"]) {
        weatherData.add({
          "time": minuteData["time"],
          "temperatureApparent": minuteData["values"]["temperatureApparent"],
          "temperature": minuteData["values"]["temperature"],
          "rainIntensity": minuteData["values"]["rainIntensity"],
          "precipitationProbability": minuteData["values"]
              ["precipitationProbability"],
        });
      }

      // Récupération des valeurs pour la première minute (par exemple)

      debugPrint(response.body.toString());
      setState(() {
        firstTime = weatherData.isNotEmpty ? weatherData[0]["time"] : "";
        firstTemperatureApparent = weatherData.isNotEmpty
            ? weatherData[0]["temperatureApparent"]
            : 0.0;
        firstTemperature = weatherData.isNotEmpty
            ? (weatherData[0]["temperature"] as num).toDouble()
            : null;
        firstRainIntensity = weatherData.isNotEmpty
            ? (weatherData[0]["rainIntensity"] as num).toDouble()
            : 0.0;
        firstPrecipitationProbability = weatherData.isNotEmpty
            ? weatherData[0]["precipitationProbability"]
            : 0;
        roundedTemp = firstTemperature!.toInt();
        roundedapTemp = firstTemperatureApparent!.toInt();
      });
    } else {
      setState(() {
        weatherData = "Failed to get weather data";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('E, d MMM').format(currentDate);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffe4f5fd),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(BootstrapIcons.list),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Center(
                        child: Text('Weather Forecast',
                            style: GoogleFonts.poiretOne(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const BoxedIcon(WeatherIcons.rain,
                            size: 30, color: Color(0xff3879e0)),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today",
                              style: GoogleFonts.poiretOne(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formattedDate,
                              style: GoogleFonts.poiretOne(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$roundedTemp",
                                style: GoogleFonts.poiretOne(
                                    fontSize: 110, fontWeight: FontWeight.bold),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "°C",
                                  style: GoogleFonts.poiretOne(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            '$city, $country',
                            style: GoogleFonts.poiretOne(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "feels like $roundedapTemp °C . Sunset 20:15",
                          style: GoogleFonts.poiretOne(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Text("Today",
                            style: GoogleFonts.poiretOne(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff03030e))),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text("Tomorrow",
                            style: GoogleFonts.poiretOne(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff03030e))),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NextDays(),
                              ));
                        },
                        child: Row(
                          children: [
                            Text(
                              "next 7 days",
                              style: GoogleFonts.poiretOne(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff3879e0)),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                size: 15, color: Color(0xff3879e0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 200,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('12AM',
                                    style: GoogleFonts.poiretOne(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                SizedBox(height: 10),
                                BoxedIcon(WeatherIcons.day_sunny,
                                    size: 30, color: Color(0xff3879e0)),
                                SizedBox(height: 10),
                                Text('26°C',
                                    style: GoogleFonts.poiretOne(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('2PM',
                                    style: GoogleFonts.poiretOne(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                SizedBox(height: 10),
                                BoxedIcon(WeatherIcons.day_cloudy,
                                    size: 30, color: Color(0xff3879e0)),
                                SizedBox(height: 10),
                                Text('26°C',
                                    style: GoogleFonts.poiretOne(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('4PM',
                                      style: GoogleFonts.poiretOne(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  SizedBox(height: 10),
                                  BoxedIcon(WeatherIcons.rain,
                                      size: 30, color: Color(0xff3879e0)),
                                  SizedBox(height: 10),
                                  Text('26°C',
                                      style: GoogleFonts.poiretOne(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('6PM',
                                    style: GoogleFonts.poiretOne(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                SizedBox(height: 10),
                                BoxedIcon(WeatherIcons.cloud,
                                    size: 30, color: Color(0xff3879e0)),
                                SizedBox(height: 10),
                                Text('26°C',
                                    style: GoogleFonts.poiretOne(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('8PM',
                                    style: GoogleFonts.poiretOne(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                SizedBox(height: 10),
                                BoxedIcon(WeatherIcons.cloud,
                                    size: 30, color: Color(0xff3879e0)),
                                SizedBox(height: 10),
                                Text('26°C',
                                    style: GoogleFonts.poiretOne(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Chance of rain',
                          style: GoogleFonts.poiretOne(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff03030e))),
                    ],
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    height: 200,
                    child: Chart(
                      layers: [
                        ChartAxisLayer(
                          settings: ChartAxisSettings(
                            x: ChartAxisSettingsAxis(
                                frequency: 1.0,
                                max: 5.0, // 6 elements on the x-axis
                                min: 0.0,
                                textStyle: GoogleFonts.poiretOne(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            y: ChartAxisSettingsAxis(
                                frequency: 100.0,
                                max: 300.0,
                                min: 0.0, // 3 elements on the y-axis
                                textStyle: GoogleFonts.poiretOne(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          labelX: (value) {
                            final labels = [
                              '10AM',
                              '12AM',
                              '2PM',
                              '4PM',
                              '6PM',
                              '8PM'
                            ];
                            if (value >= 0 && value < labels.length) {
                              return labels[value.toInt()];
                            } else {
                              return '';
                            }
                          },
                          labelY: (value) {
                            if (value == 0) {
                              return 'heavy\nrain';
                            } else if (value == 100) {
                              return 'rainy';
                            } else if (value == 200) {
                              return 'sunny';
                            } else {
                              return '';
                            }
                          },
                        ),
                        ChartBarLayer(
                          items: List.generate(
                            6, // 6 elements on the x-axis
                            (index) => ChartBarDataItem(
                              color:
                                  index == 3 // Change color for 4PM (index 3)
                                      ? const Color(0xFFFFD700) // Yellow
                                      : const Color(0xFF000000), // Black
                              value: generateRandomValues(6, 3)[index],
                              x: index.toDouble(),
                            ),
                          ),
                          settings: const ChartBarSettings(
                            thickness: 16.0, // Adjust thickness for wider bars
                            radius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
