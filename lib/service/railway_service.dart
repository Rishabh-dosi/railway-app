import 'dart:convert';

import 'package:http/http.dart' as http;

class RailwayService{
  final String baseUrl = "https://catfact.ninja/fact";
  Future<Map<String, dynamic>> fetchItem() async{
    final response = await http.get((Uri.parse(baseUrl)));
    if(response.statusCode == 200)
    {
      return json.decode(response.body);
    }else {
    throw Exception("Failed to load items");
    }

  }

}