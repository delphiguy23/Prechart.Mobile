import 'package:flutter/material.dart';
import 'package:prechart_mobile/models/werkgeverModel.dart';

class WerkgeversLists with ChangeNotifier{

  List<Werkgever> _werkgevers = [];

  List<Werkgever> get werkgevers => _werkgevers;

  void setWerkgevers(List<Werkgever> werkgevers){
    _werkgevers = werkgevers;
    notifyListeners();
  }

  void clearPersons(){
    _werkgevers.clear();
    notifyListeners();
  }
}