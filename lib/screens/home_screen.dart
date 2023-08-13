import 'package:flutter/material.dart';
import 'package:spin_wheel_app/screens/spinner_screen.dart';
import 'package:spin_wheel_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  late List<String> spinnerItems = [];

  String? textFieldValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Add Items To Spin Wheel',
            style: TextStyle(fontSize: 20, fontFamily: 'Ubuntu'),
          ),
          const SizedBox(
            height: 20,
            width: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  keyboardAppearance: Brightness.light,
                  controller: _textEditingController,
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    textFieldValue = value;
                  },
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (textFieldValue != null) {
                        spinnerItems.add(textFieldValue!);
                        _textEditingController.clear();
                        textFieldValue = null;
                      }
                    });
                  },
                  style: kButtonStyle(),
                  child: const Text('Add item')),
              const SizedBox(width: 10),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: spinnerItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${index + 1}. ${spinnerItems[index]}'),
                    trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            spinnerItems.removeAt(index);
                          });
                        },
                        child: const Icon(Icons.delete, color: Colors.red)),
                  );
                }),
          ),
          ElevatedButton(
              onPressed: () {
                if (!checkSpinnerItemsLength(spinnerItems)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertBoxWidget();
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpinnerScreen(
                        spinnerItems: this.spinnerItems,
                      ),
                    ),
                  );
                }
              },
              style: kButtonStyle(),
              child: const Text(
                'Check Your Luck',
                style: TextStyle(fontFamily: 'Roboto'),
              )),
        ],
      ),
    ));
  }
}

class AlertBoxWidget extends StatelessWidget {
  const AlertBoxWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Alert'),
      content:
          const Text('You need at least 2 and at most 8 items in the list.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

bool checkSpinnerItemsLength(List<String> items) {
  if (items.length >= 2 && items.length <= 8) {
    return true;
  } else {
    return false;
  }
}
