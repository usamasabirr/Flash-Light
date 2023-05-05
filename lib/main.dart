import 'package:flash_light/development/development.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Light',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<double?> whenNotZero(Stream<double> source) async {
    await for (double value in source) {
      print("Width:" + value.toString());
      if (value > 0) {
        print("Width > 0: " + value.toString());
        return value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //get the height and width of the screen
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      //When creating the build for release mode
      //mediaquery returns 0 sometimes, so we are making sure
      //that if mediaquery return 0 show Loading Text
      //otherwise go to the development screen
      child: FutureBuilder(
          future: whenNotZero(
            Stream<double>.periodic(Duration(milliseconds: 50),
                (x) => MediaQuery.of(context).size.width),
          ),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data! > 0) {
                return Development(
                    mediaWidth: mediaWidth, mediaHeight: mediaHeight);
              }
            } else {
              return Container();
            }
            return Text('Loading');
          }),
    ));
  }
}
