
import 'package:flutter/material.dart';
import 'package:railway_app/train_page.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Railway App",  style: TextStyle(color: Colors.teal),),
        backgroundColor: Colors.white54,

      ),
      body: Container(
        padding: EdgeInsets.all(19),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the Column content
            children: [
              _buildCustomButton("Click Here To Check "
                  "Live Status" , context),
              SizedBox(height: 20),
              _buildCustomButton("Click Here To Check PNR Status" , context),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildCustomButton(String text, BuildContext context) {
  return InkWell(
    onTap: () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrainPage()),
    );
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

