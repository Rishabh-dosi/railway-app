import 'package:flutter/material.dart';
import 'package:railway_app/service/railway_service.dart';  // Import the service class
import 'dart:convert';  // To encode the Map as a string for displaying

class TrainPage extends StatefulWidget {
  const TrainPage({super.key});

  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  String _trainNo = ''; // Store the entered train number
  DateTime? _selectedDate; // Store the selected date
  final RailwayService _railwayService = RailwayService(); // Instance of the service
  Map<String, dynamic> _apiResponse = {}; // Store the entire API response as a map
  bool _isLoading = false; // To manage loading state

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
            // TextField to enter the train number
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
                  _trainNo = text; // Update train number on text change
                });
              },
            ),
            SizedBox(height: 20),

            Row(
              children: [
                // Calendar icon to open the date picker
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

                // Search Button to call the API
                IconButton(
                  onPressed: () async {
                    if (_trainNo.isNotEmpty && _selectedDate != null) {
                      setState(() {
                        _isLoading = true;
                        _apiResponse = {}; // Clear previous response
                      });

                      try {
                        var resp = await _railwayService.fetchItem();

                        setState(() {
                          _apiResponse = resp;
                        });
                      } catch (e) {
                        setState(() {
                          _apiResponse = {"error": "Error: $e"};
                        });
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    } else {
                      setState(() {
                        _apiResponse = {"error": "Please enter a train number and select a date."};
                      });
                    }
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Display train number entered
            Text('Train Number: $_trainNo'),

            if (_isLoading) CircularProgressIndicator(),

            // Display the entire API response map as a string
            if (_apiResponse.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  jsonEncode(_apiResponse), // Display the entire map as a string
                  style: TextStyle(color: Colors.blue),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
