import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:native_features/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _baterryLevel = "Unknown";

  static const platform = const MethodChannel(CHANNEL_BATTERY);

  Future<void> _getBatteryLevel() async {
    String batteryLevel;

    try {
      final int result =
          await platform.invokeMethod(CHANNEL_METHOD_BATTERY_GET);
      batteryLevel = '${result}% Battery Level .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}";
    } catch (e) {
      batteryLevel = "Error: '${e.message}";
    }

    setState(() {
      _baterryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                _baterryLevel,
                style: TextStyle(fontSize: 24),
              ),
            ),
            RaisedButton(
                child: Text('Get Battery Level'), onPressed: _getBatteryLevel),
          ],
        ),
      ),
    );
  }
}
