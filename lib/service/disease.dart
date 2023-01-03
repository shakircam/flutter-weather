

import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:weather/models/company_network.dart';
import 'package:weather/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../models/company.dart';
import '../models/disease_category.dart';

class Disease{

  Future<CompanyNetwork> getCompany() async{

    final Map<String, String> queries =  <String, String>{};
    queries['limit'] = '50';
    queries['page'] = '1';
    queries['date'] = '2022-09-08';

    var url = Uri.parse('$baseUrl/api/drugs/companies');
    final finalUri = url.replace(queryParameters: queries);

    final Map<String, String> header =  <String, String>{};
    header['Authorization'] = 'Bearer $token';
    header['Accept'] = 'application/';

    var response = await http.get(
        finalUri,
        headers: header
    );

    if(response.statusCode == 200){
      debugPrint("company status code: ${response.statusCode}");
      return CompanyNetwork.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load album');
    }


  }

  Future<void> getDiseaseCategory() async{

    final Map<String, String> queries =  <String, String>{};
    queries['limit'] = '50';
    queries['page'] = '1';
    queries['date'] = '2022-09-08';

    var url = Uri.parse('$baseUrl/api/diseases/categories');
    final finalUri = url.replace(queryParameters: queries);

    final Map<String, String> header =  <String, String>{};
    header['Authorization'] = 'Bearer $token';
    header['Accept'] = 'application/';

    var response = await http.get(
      finalUri,
      headers: header
    );
    print("disease status code: ${response.statusCode}");
    var body = await json.decode(response.body );

    body.forEach((key, value) {
      if(key == 'data'){
        log('disease :: $key value:: $value');
      }
    });

    /*for(var i=0; i<body.length; i++){
        print('disease :: ${DiseaseCategory.fromJson(body[i])}');

    }*/

  }
}