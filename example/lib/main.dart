import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:idnow/idnow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _idnowPlugin = Idnow();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _idnowPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  final _ctrl = TextEditingController(text: 'TS2-GTWCB');
  var _result = '';

  void _onTap() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;

    final res = await Idnow().startIdentification(text);
    setState(() => _result = '$res');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            const Spacer(),
            TextField(
              controller: _ctrl,
            ),
            const Spacer(),
            TextButton(
              onPressed: _onTap,
              child: const Text('Start Indentification'),
            ),
            const Spacer(),
            Text('Result: $_result'),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
