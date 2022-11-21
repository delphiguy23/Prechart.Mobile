import 'dart:convert';
import 'package:prechart_mobile/models/personCumulatiefModel.dart';

import '../models/tokensModel.dart';
import 'package:http/http.dart' as http;

import '../models/werkgeverModel.dart' ;
import '../models/personModel.dart' ;

class Endpoints {
  static const String userValidate =
      'https://prd-zekerheyd-user.prechart.com/platform/service/api/users/validate';

  static const String werkgeversAll =
      'https://prd-zekerheyd-werkgever.prechart.com/platform/service/api/werkgever/all';

  static const String personsWergeverAll =
      'https://prd-zekerheyd-person.prechart.com/platform/service/api/person/werkgever/';

  static const String personsEmployeeAll =
      'https://prd-zekerheyd-person.prechart.com/platform/service/api/person/type/1';

  static const String personsCumulatiefs =
      'https://prd-zekerheyd-person.prechart.com/platform/service/api/person/cumulative/';

  static const String berekeningen =
      'https://prd-zekerheyd-berekening.prechart.com/platform/service/api/berekening/';

  // static const String local_userValidate =
  //     'https://prd-zekerheyd-user.prechart.com/platform/service/api/users/validate';
  //
  // static const String local_werkgeversAll =
  //     'https://prd-zekerheyd-werkgever.prechart.com/platform/service/api/werkgever/all';
  //
  // static const String local_personsWergeverAll =
  //     'https://prd-zekerheyd-person.prechart.com/platform/service/api/person/werkgever/';
  //
  // static const String local_personsEmployeeAll =
  //     'https://prd-zekerheyd-person.prechart.com/platform/service/api/person/type/1';
  //
  // static const String local_personsCumulatiefs =
  //     'https://prd-zekerheyd-person.prechart.com/platform/service/api/person/cumulative/';
  //
  // static const String local_berekeningen =
  //     'https://prd-zekerheyd-berekening.prechart.com/platform/service/api/berekening/';

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

      var response = await httpClient.get(
        Uri.parse(personsWergeverAll + taxNo),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var json = response.body;
        return personFromJson(json);
      }
    }
  }

  Future<List<Person>?> getEmployeePersons() async{
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
        Uri.parse(personsEmployeeAll),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var json = response.body;
        return personFromJson(json);
      }
    }
  }

  Future<PersonCumulatief?> getPersonCumulatief(String bsn) async{
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
        Uri.parse(personsCumulatiefs + bsn),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var json = response.body;
        return personCumulatieveFromJson(json);
      }
    }
  }
}
