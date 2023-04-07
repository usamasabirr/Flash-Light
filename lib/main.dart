import 'package:device_preview/device_preview.dart';
import 'package:flash_light/development/development.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(DevicePreview(enabled: true, builder: (context) => MyApp()));
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

          Development(mediaWidth: mediaWidth, mediaHeight: mediaHeight),
    ));
  }
}
