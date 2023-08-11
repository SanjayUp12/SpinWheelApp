import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:spin_wheel_app/screens/home_screen.dart';
import 'package:spin_wheel_app/utils/constants.dart';

class SpinnerScreen extends StatefulWidget {
  SpinnerScreen({this.spinnerItems});
  List<String>? spinnerItems;
  @override
  State<SpinnerScreen> createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen> {
  StreamController<int> selected = StreamController<int>.broadcast();
  StreamSubscription<int>? selectedSubscription;
  String result = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyanAccent,
        body: Column(
          children: [
            Text(
              'Spinner Screen',
              style: TextStyle(fontFamily: 'Roboto', fontSize: 20),
            ),
            Expanded(
              child: FortuneWheel(
                animateFirst: false,
                selected: selected.stream,
                items: [
                  for (var it in widget.spinnerItems!)
                    FortuneItem(
                        child: Text(
                      it,
                      style: kSpinnerItemTextStyle,
                    )),
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
                          title: Image(
                            image:
                                AssetImage('assets/images/spinwheelicon.png'),
                          ),
                          content: Text(
                            'Thank You . You got.....  \' $result\'',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.blue),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text(
                                    'Spin Again',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen())); // Close the dialog
                                  },
                                  child: Text(
                                    'Go to Home Screen',
                                  ),
                                )
                              ],
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
              child: Text('Spin the wheel'),
              style: kButtonStyle(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    selectedSubscription?.cancel();
    selected.close();
    super.dispose();
  }
}
