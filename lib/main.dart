import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/app_retain_widget.dart';
import 'package:flutter_background/background_main.dart';
import 'package:flutter_background/counter_service.dart';
import 'package:flutter_background/screens/halaman_root.dart';
import 'package:flutter_background/models/model_user_function.dart';

import 'package:flutter_background/screens/halaman_login.dart';
import 'package:flutter_background/screens/halaman_beranda.dart';
import 'package:flutter_background/screens/halaman_tambah_edit.dart';


void main() {
  runApp(MyApp());

  var channel = const MethodChannel('com.example/background_service');
  var callbackHandle = PluginUtilities.getCallbackHandle(backgroundMain);
  channel.invokeMethod('startService', callbackHandle.toRawHandle());

  CounterService().startCounting();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library PPNS',
      home: AppRetainWidget(
        child: HalamanRoot(user: new User()),
      ),
      routes: {
        HalamanRoot.id: (context) => HalamanRoot(),
        HalamanLogin.id: (context) => HalamanLogin(),
        HalamanBeranda.id: (context) => HalamanBeranda(),
        HalamanTambahEdit.id: (context) => HalamanTambahEdit()
      },

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library PPNS'),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: CounterService().count,
          builder: (context, count, child) {
            return Text('Counting: $count');
          },
        ),
      ),
    );
  }
}
