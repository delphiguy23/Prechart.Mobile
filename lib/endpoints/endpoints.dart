import 'dart:convert';


import '../models/tokensModel.dart';
import 'package:http/http.dart' as http;

import '../models/werkgeverModel.dart' ;
import '../models/personModel.dart' ;

// https://prd-zekerheyd-person.prechart.com/
// https://prd-zekerheyd-user.prechart.com/
// https://prd-zekerheyd-werkgever.prechart.com/


class Endpoints {
  static const String userValidate =
      'https://prd-zekerheyd-user.prechart.com/platform/service/api/users/validate';

  static const String werkgeversAll =
      'https://prd-zekerheyd-werkgever.prechart.com/platform/service/api/werkgever/all';

  static const String personsAll =
      'https://prd-zekerheyd-person.prechart.com/platform/service/api/person/werkgever/';

  var userCredential = jsonEncode(<String, String>{
    'userName': 'ADMIN',
    'password': 'ADMIN',
  });

  var httpClient = http.Client();
  String? bearerToken = '';

  Future<Tokens?> getTokens() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };

    var response = await httpClient.post(
      Uri.parse(userValidate),
      headers: headers,
      body: userCredential,
    );

    if (response.statusCode == 200) {
      var json = response.body;
      return tokensFromJson(json);
    }
  }

  Future<List<Werkgever>?> getWerkgevers() async {
    if (bearerToken == null || bearerToken == '') {
      var tokens = await getTokens();
      bearerToken = tokens!.bearerToken;
    }

    if (bearerToken != null && bearerToken != '') {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $bearerToken',
      };

      var response = await httpClient.get(
        Uri.parse(werkgeversAll),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var json = response.body;
        return werkgeverFromJson(json);
      }
    }
  }

  Future<List<Person>?> getPersons(String taxNo) async{
    if (bearerToken == null || bearerToken == '') {
      var tokens = await getTokens();
      bearerToken = tokens!.bearerToken;
    }

    if (bearerToken != null && bearerToken != '') {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $bearerToken',
      };

      var uri = personsAll + taxNo;
      print(uri);

      var response = await httpClient.get(
        Uri.parse(personsAll + taxNo),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print('Persons Ok.');
        var json = response.body;
        return personFromJson(json);
      }
    }
  }
}
