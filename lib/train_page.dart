import 'package:flutter/material.dart';

class TrainPage extends StatefulWidget {
  const TrainPage({super.key});

  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  String _trainNo = ''; // Initialize with an empty string
  DateTime? _selectedDate; // Make it nullable initially

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Railway App"),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // TextField to enter train number
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: "Enter Train Number",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (text) {
                setState(() {
                  _trainNo = text; // Update _trainNo when text changes
                });
              },
            ),
            SizedBox(height: 20),

            Row(
              children: [
                // Calendar icon to open date picker
                IconButton(
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now().subtract(Duration(days: 2)),
                      lastDate: DateTime.now().add(Duration(days: 2)),
                      initialDate: DateTime.now(),
                    );

                    // If a date is selected, update the state
                    if (selectedDate != null) {
                      setState(() {
                        _selectedDate = selectedDate;
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_today),
                ),
                SizedBox(width: 8),
                // Display selected date if it exists
                Text(
                  _selectedDate != null
                      ? "${_selectedDate!.toLocal()}".split(' ')[0]
                      : "No date selected",
                ),

                Spacer(),
                IconButton(onPressed: (){ print(_trainNo + " " + _selectedDate.toString());}, icon: Icon(Icons.search))
              ],
            ),
            SizedBox(height: 20),

            // Display the train number entered
            Text('Train Number: $_trainNo'),
          ],
        ),
      ),
    );
  }
}
