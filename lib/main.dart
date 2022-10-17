import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_theming/theme/theme_constants.dart';
import 'package:flutter_theming/theme/theme_manager.dart';
import 'package:flutter_theming/utils/helper_widgets.dart';

void main() {
  runApp(MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text("Soap Level Monitoring App"),
        actions: [
          Switch(
              value: _themeManager.themeMode == ThemeMode.dark,
              onChanged: (newValue) {
                _themeManager.toggleTheme(newValue);
              })
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/hand.png",
                width: 200,
                height: 200,
              ),
              addVerticalSpace(30),
              Text(
                "Soap Level %",
                style: _textTheme.headline4?.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              addVerticalSpace(10),
              Divider(
                color: isDark ? Colors.white : Colors.black,
                indent: 100,
                endIndent: 100,
                height: 20,
              ),
              addVerticalSpace(20),
              Text(
                "Real Time Monitoring",
                style: _textTheme.subtitle1,
              ),
              addVerticalSpace(70),
              ElevatedButton(
                  child: Text("About the App"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          title: Text("About the Project"),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/soap_dispenser.png",
                  ),
                  addVerticalSpace(10),
                  Text(
                    "Soap Sanitizer Monitoring Level",
                    style: _textTheme.headline4?.copyWith(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: isDark ? Colors.white : Colors.black,
                    indent: 20,
                    endIndent: 20,
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.50),
                    child: Text(
                      "Composed of both hardware and software attributes, this system allows the dispensal of (but not limited to) soap sanitizer upon detection of hand at proximity. The integration of ultrasonic sensors also allow for the monitoring of the liquid and data is then passed through to this mobile application.",
                      style: _textTheme.subtitle1,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  addVerticalSpace(30),
                  ElevatedButton(
                      child: Text("Back"),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              )),
        ));
  }
}
