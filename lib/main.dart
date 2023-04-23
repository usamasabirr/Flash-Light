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
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    var topPadding = MediaQuery.of(context).padding.top;
    var bottomPadding = MediaQuery.of(context).padding.bottom;

    var height = mediaHeight - topPadding;

    return Scaffold(
        body: SafeArea(
      child:

          //         Container(
          //   color: Colors.grey,
          //   height: mediaHeight,
          //   width: mediaWidth,
          // )
          FutureBuilder(
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
