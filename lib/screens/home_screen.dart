import 'package:flutter/material.dart';
import 'package:spin_wheel_app/screens/spinner_screen.dart';
import 'package:spin_wheel_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textEditingController = TextEditingController();

  late List<String> spinnerItems = [];

  String? textFieldValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Text(
            'Add items to spin wheels please',
            style: TextStyle(fontSize: 20, fontFamily: 'Ubuntu'),
          ),
          SizedBox(
            height: 10,
            width: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    textFieldValue = value;
                  },
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (textFieldValue != null) {
                      spinnerItems.add(textFieldValue!);
                      _textEditingController.clear();
                    }
                  });
                },
                child: Text('Add item'),
                style: kButtonStyle(),
              ),
              SizedBox(width: 10),
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
                        child: Icon(Icons.delete, color: Colors.red)),
                  );
                }),
          ),
          ElevatedButton(
            onPressed: () {
              if (!checkSpinnerItemsLength(spinnerItems)) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertBoxWidget();
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
            child: Text(
              'Check Your Luck',
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            style: kButtonStyle(),
          ),
        ],
      ),
    ));
  }
}

class AlertBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Alert'),
      content: Text('You need at least 2 and at most 8 items in the list.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

bool checkSpinnerItemsLength(List<String> items) {
  if (items.length >= 2 && items.length < 8) {
    return true;
  } else {
    return false;
  }
}
