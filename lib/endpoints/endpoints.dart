import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:prechart_mobile/helpers/helpers.dart';
import 'package:prechart_mobile/models/berekeningenModel.dart' as berekeningen;
import 'package:prechart_mobile/models/calculationParametersModel.dart';
import 'package:prechart_mobile/models/personCumulatiefModel.dart';
import 'package:prechart_mobile/models/taxYearModel.dart';
import 'package:prechart_mobile/models/userModel.dart';
import 'package:prechart_mobile/models/woonlandModel.dart';

import '../models/tokensModel.dart';
import 'package:http/http.dart' as http;

import '../models/werkgeverModel.dart';
import '../models/personModel.dart';

class Endpoints {
  String userCredential = '';

  var httpClient = http.Client();
  String? bearerToken = '';

  Future<Tokens?> Login(String userName, String password) async {
    userCredential = jsonEncode(<String, String>{
      'userName': userName,
      'password': password,
    });

    var tokens = await getTokens();

    if (tokens != null && tokens.bearerToken != null) {
      bearerToken = tokens.bearerToken;
      return tokens;
    } else {
      return null;
    }
  }

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

  Future<List<Werkgever>?> getWerkgevers(UserModel tokens) async {
    bearerToken = tokens.bearerToken;

    if (Jwt.isExpired(bearerToken ?? '')) {
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

  Future<List<Person>?> getPersons(String taxNo, UserModel tokens) async {
    bearerToken=tokens.bearerToken;

    if (Jwt.isExpired(bearerToken ?? '')) {
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

  Future<List<Person>?> getEmployeePersons(UserModel tokens) async {
    bearerToken=tokens.bearerToken;
    if (Jwt.isExpired(bearerToken ?? '')) {
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

  Future<PersonCumulatief?> getPersonCumulatief(String bsn, UserModel tokens) async {
    bearerToken=tokens.bearerToken;
    if (Jwt.isExpired(bearerToken ?? '')) {
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

  Future<List<WoonlandModel>?> getAllWoonlandBeginsel(UserModel tokens) async {
    bearerToken=tokens.bearerToken;
    if (Jwt.isExpired(bearerToken ?? '')) {
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
        Uri.parse(allWoonlandBeginsel),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var json = response.body;
        return woonlandModelFromJson(json);
      }
    }
  }

  Future<List<int>?> getTaxYears(UserModel tokens) async {
    bearerToken = tokens.bearerToken;

    if (Jwt.isExpired(bearerToken ?? '')) {
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
        Uri.parse(taxYear),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var json = response.body;
        return taxYearModelFromJson(json);
      }
    }
  }

  Future<berekeningen.BerekeningenModel?> calculateBerekeningen(
      CalculationParametersModel parameters, UserModel tokens) async {
    bearerToken = tokens.bearerToken;

    if (Jwt.isExpired(bearerToken ?? '')) {
      var tokens = await getTokens();
      bearerToken = tokens!.bearerToken;
    }

    if (bearerToken != null && bearerToken != '') {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $bearerToken',
      };

      var jsonParameters = calculationParametersToJson(parameters);

      var response = await httpClient.post(
        Uri.parse(calculate),
        headers: headers,
        body: jsonParameters,
      );

      if (response.statusCode == 200) {
        var json = response.body;
        return berekeningen.berekeningenModelFromJson(json);
      }
    }
  }
}
