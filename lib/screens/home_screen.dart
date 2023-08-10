import 'package:flutter/material.dart';
import 'package:spin_wheel_app/screens/spinner_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textEditingController = TextEditingController();

  late List<String> spinnerItems = [];

  String textFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Text(
            'Add items to spin wheels please',
            style: TextStyle(fontSize: 20),
          ),
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item to display on spinner'),
            onChanged: (value) {
              textFieldValue = value;
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                spinnerItems.add(textFieldValue);
                _textEditingController.clear();
              });
            },
            child: Text('Add item'),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: spinnerItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: ListTile(
                      title: Text('${index + 1}. ${spinnerItems[index]}'),
                    ),
                    onLongPress: () {
                      setState(() {
                        spinnerItems.removeAt(index);
                      });
                    },
                  );
                }),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SpinnerScreen()));
              },
              child: Text('Check Your Luck')),
        ],
      ),
    ));
  }
}

// void checkSpinnerItemsLength( List<String> items)
// {
//   if(items.length<=2)
//     {
//       return AlertDialog()
//     }
// }
