import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NextDays extends StatefulWidget {
  const NextDays({super.key});

  @override
  State<NextDays> createState() => _NextDaysState();
}

class _NextDaysState extends State<NextDays> {
  DateTime now = DateTime.now();
  String currentDay = '';
  String nextDay = '';
  String thirdDay = '';
  String fourthDay = '';
  String fifthDay = '';
  String sixthDay = '';
  String seventhDay = '';

  void initState() {
    super.initState();
    getCurrentDate();
  }

  void getCurrentDate() {
    setState(
      () {
        now = DateTime.now();
        currentDay = DateFormat.EEEE().format(now);
        nextDay = DateFormat.EEEE().format(now.add(const Duration(days: 1)));
        thirdDay = DateFormat.EEEE().format(now.add(const Duration(days: 2)));
        fourthDay = DateFormat.EEEE().format(now.add(const Duration(days: 3)));
        fifthDay = DateFormat.EEEE().format(now.add(const Duration(days: 4)));
        sixthDay = DateFormat.EEEE().format(now.add(const Duration(days: 5)));
        seventhDay = DateFormat.EEEE().format(now.add(const Duration(days: 6)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 251, 254),
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
                  const SizedBox(
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
                height: 10,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(BootstrapIcons.chevron_left),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'next ',
                        style: GoogleFonts.poiretOne(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '7 days',
                            style: GoogleFonts.poiretOne(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 10,
                      child: SizedBox(
                        height: 150,
                        width: 350,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentDay,
                                        style: GoogleFonts.poiretOne(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      const Icon(
                                        BootstrapIcons.cloud_sun_fill,
                                        size: 25,
                                        color: Color(0xff3879e0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '54°C',
                                        style: GoogleFonts.poiretOne(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '19°C',
                                        style: GoogleFonts.poiretOne(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Wind',
                                        style: GoogleFonts.poiretOne(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                        ),
                                      ),
                                      const SizedBox(width: 50),
                                      Text(
                                        '12 m/h',
                                        style: GoogleFonts.poiretOne(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Humidity',
                                          style: GoogleFonts.poiretOne(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        Text(
                                          '55%',
                                          style: GoogleFonts.poiretOne(
                                            fontSize: 12,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Visibility',
                                        style: GoogleFonts.poiretOne(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Text(
                                        '25 km',
                                        style: GoogleFonts.poiretOne(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'UV',
                                          style: GoogleFonts.poiretOne(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                          ),
                                        ),
                                        const SizedBox(width: 70),
                                        Text(
                                          '1',
                                          style: GoogleFonts.poiretOne(
                                            fontSize: 12,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'SUN',
                              style: GoogleFonts.poiretOne(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  BootstrapIcons.droplet_fill,
                                  color: Color(0xff3879e0),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '54°C',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        const Icon(
                          BootstrapIcons.cloud_sun_fill,
                          color: Color(0xff3879e0),
                          size: 30,
                        ),
                        const SizedBox(width: 30),
                        Text(
                          '15° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          height: 25,
                          width: 60, // Hauteur de l'ovale
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(
                                          25), // Rayon pour la partie grise
                                      right: Radius.zero,
                                    ),
                                    color: Color.fromARGB(255, 210, 228, 248),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(25),
                                      left: Radius.zero,
                                    ),
                                    color: Color.fromARGB(255, 246, 69, 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        Text(
                          '24° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'MON',
                              style: GoogleFonts.poiretOne(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  BootstrapIcons.droplet_fill,
                                  color: Color(0xff3879e0),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '54°C',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        const Icon(
                          BootstrapIcons.sun_fill,
                          color: Color.fromARGB(255, 244, 197, 19),
                          size: 30,
                        ),
                        const SizedBox(width: 30),
                        Text(
                          '19° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(width: 45),
                        SizedBox(
                          height: 25,
                          width: 60,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25),
                                      right: Radius.zero,
                                    ),
                                    color: Color.fromARGB(255, 210, 228, 248),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(25),
                                      left: Radius.zero,
                                    ),
                                    color: Color.fromARGB(255, 246, 69, 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '28° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'TUE',
                              style: GoogleFonts.poiretOne(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  BootstrapIcons.droplet_fill,
                                  color: Color(0xff3879e0),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '54°C',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        const Icon(
                          BootstrapIcons.cloud_sun_fill,
                          color: Color(0xff3879e0),
                          size: 30,
                        ),
                        const SizedBox(width: 30),
                        Text(
                          '17° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(width: 40),
                        SizedBox(
                          height: 25,
                          width: 60,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25),
                                      right: Radius.zero,
                                    ),
                                    color: Color.fromARGB(255, 210, 228, 248),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(25),
                                      left: Radius.zero,
                                    ),
                                    color: Color.fromARGB(255, 246, 69, 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 25),
                        Text(
                          '25° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'WED',
                              style: GoogleFonts.poiretOne(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  BootstrapIcons.droplet_fill,
                                  color: Color(0xff3879e0),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '54°C',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        const Icon(
                          BootstrapIcons.cloud_lightning_rain_fill,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 30,
                        ),
                        const SizedBox(width: 30),
                        Text(
                          '15° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(width: 11),
                        SizedBox(
                          height: 25,
                          width: 60,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25),
                                      right: Radius.zero,
                                    ),
                                    color: Color.fromARGB(255, 210, 228, 248),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(25),
                                      left: Radius.zero,
                                    ),
                                    color: Color.fromARGB(255, 246, 69, 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 55),
                        Text(
                          '21° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'THU',
                              style: GoogleFonts.poiretOne(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  BootstrapIcons.droplet_fill,
                                  color: Color(0xff3879e0),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '54°C',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        const Icon(
                          BootstrapIcons.cloud_rain_fill,
                          color: Color(0xff3879e0),
                          size: 30,
                        ),
                        const SizedBox(width: 30),
                        Text(
                          '14° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(width: 11),
                        SizedBox(
                          height: 25,
                          width: 50,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25),
                                      right: Radius.circular(25),
                                    ),
                                    color: Color.fromARGB(255, 210, 228, 248),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 65),
                        Text(
                          '18° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'FRI',
                              style: GoogleFonts.poiretOne(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  BootstrapIcons.droplet_fill,
                                  color: Color(0xff3879e0),
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '54°C',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        const Icon(
                          BootstrapIcons.sun_fill,
                          color: Color.fromARGB(255, 244, 197, 19),
                          size: 30,
                        ),
                        const SizedBox(width: 30),
                        Text(
                          '18° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(width: 45),
                        SizedBox(
                          height: 25,
                          width: 50,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25),
                                      right: Radius.zero,
                                    ),
                                    color: Color.fromARGB(255, 210, 228, 248),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(25),
                                      left: Radius.zero,
                                    ),
                                    color: Color.fromARGB(255, 246, 69, 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                        Text(
                          '24° C',
                          style: GoogleFonts.poiretOne(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
