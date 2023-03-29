import 'package:flash_light/custom_line.dart';
import 'package:flash_light/dragable_example.dart';
import 'package:flash_light/flutter_sample.dart';
import 'package:flash_light/lamp.dart';
import 'package:flash_light/try/animate_path_try.dart';
import 'package:flash_light/try/cord_stretch.dart';
import 'package:flash_light/try/multi_tween.dart';
import 'package:flash_light/try/spring_package.dart';
import 'package:flash_light/try/spring_simulation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
    return Scaffold(
        body: SafeArea(
      child: MultiTween(mediaWidth: mediaWidth, mediaHeight: mediaHeight),
    ));
  }
}
