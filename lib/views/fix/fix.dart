import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assignment_test/dataModel/model.dart';

class FixTab extends StatefulWidget {
  FixTab({Key? key}) : super(key: key);

  @override
  _FixTabState createState() => _FixTabState();
}

class _FixTabState extends State<FixTab> {
  Person? person = Male(26, 166);
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Wrap(
          children: [
            for (var i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.red,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Center(child: Text('$i', style: const TextStyle(color: Colors.white))),
                ),
              ),
          ],
        ),
        const Divider(thickness: 5, color: Colors.black),
        ChangeNotifierProvider(
          create: (context) => FixProvider(),
          builder: (context, _) {
            return Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Text('Counter: ${context.watch<FixProvider>().counter.toString()}'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    context.read<FixProvider>().increaseCounter();
                  },
                  child: const Text('Increase Counter'),
                )
              ],
            );
          },
        ),
        const Divider(thickness: 5, color: Colors.black),
        Text('Ideal weight: $result'),
        ElevatedButton(
          onPressed: () {
            _showInputDialog(context);
          },
          child: const Text('Add height and age'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (person is Male) {
                result = 'Male ideal weight: ${(person as Male).getIdealWeight()}';
              } else if (person is Female) {
                result = 'Female ideal weight: ${(person as Female).getIdealWeight()}';
              }
            });
          },
          child: const Text('Calculate weight'),
        )
      ],
    );
  }

  Future<void> _showInputDialog(BuildContext context) async {
    TextEditingController ageController = TextEditingController();
    TextEditingController heightController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Age and Height'),
          content: Column(
            children: [
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Height'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate and set the values
                if (ageController.text.isNotEmpty && heightController.text.isNotEmpty) {
                  setState(() {
                    person = Male(int.parse(ageController.text), double.parse(heightController.text));
                  });
                  Navigator.of(context).pop();
                } else {
                  // Show an error or handle validation
                  // For simplicity, showing a print statement
                  print('Please enter valid age and height');
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class FixProvider extends ChangeNotifier {
  int? counter;

  FixProvider() : counter = 0;

  void increaseCounter() {
    counter = counter! + 1;
    notifyListeners();
  }
}
