import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SpinnerScreen extends StatefulWidget {
  SpinnerScreen({this.spinnerItems});
  List<String>? spinnerItems;

  @override
  State<SpinnerScreen> createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen> {
  // const SpinnerScreen({Key? key}) : super(key: key);
  StreamController<int> selected = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Spinner Screen'),
          Expanded(
            child: FortuneWheel(
              animateFirst: false,
              selected: selected.stream,
              items: [
                for (var it in widget.spinnerItems!)
                  FortuneItem(child: Text(it)),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  selected
                      .add(Fortune.randomInt(0, widget.spinnerItems!.length));
                });
              },
              child: Text('Spin the wheel')),
        ],
      ),
    );
  }
}
