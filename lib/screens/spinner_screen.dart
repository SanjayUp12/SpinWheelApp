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
  StreamController<int> selected = StreamController<int>.broadcast();
  StreamSubscription<int>? selectedSubscription;
  String? result;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                onAnimationEnd: () async {
                  selectedSubscription =
                      await selected.stream.listen((selectedValue) {
                    result = widget.spinnerItems![selectedValue];
                  });

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Alert'),
                          content: Text(
                              'You need at least 2 and at most 8 items in the list.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('${result}'),
                            ),
                          ],
                        );
                      });
                },
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
      ),
    );
  }

  @override
  void dispose() {
    selectedSubscription?.cancel();
    super.dispose();
  }
}
