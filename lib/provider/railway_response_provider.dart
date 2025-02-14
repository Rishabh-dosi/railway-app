import 'package:flutter/material.dart';
import 'package:railway_app/service/railway_service.dart';

class ResponseProvider extends ChangeNotifier{
  List<Map<String, dynamic>> _resp = [];
  bool _isLoading = false;
  Map<String, dynamic> get response => _resp;
  bool get isLoading => _isLoading;

  Future<void> fetchResp() async{
    _isLoading = true;
    notifyListeners();

    try{
      _resp = await RailwayService().fetchItem();
    }catch (e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

}