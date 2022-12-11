

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'exception.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://api.themoviedb.org/3/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {

      final response = await get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }


  List<Map> data = [


    {
  "id": 6,
  "title": "CLINICAL FEATURES",
  "value": "<p>Acne is a common chronic disorder affecting the hair follicle and sebaceous gland, characterised by a mixed eruption of inflammatory and non-inflammatory skin lesions. [IMG-3]<br>Acne affects both sexes and all races.</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>",
  "order": 1,
  "disease_id": 2,
  "image_list": "[IMG-3]",
  "image_id": 3,
  "medicines": [],
  "created_at": "2022-09-27T06:54:43.000000Z",
  "updated_at": "2022-09-27T10:22:13.000000Z",
  "deleted_at": "2022-09-27T10:22:13.000000Z"
  },
    {
      "id": 6,
      "title": "CLINICAL FEATURES",
      "value": "<p>Acne is a common chronic disorder affecting the hair follicle and sebaceous gland, characterised by a mixed eruption of inflammatory and non-inflammatory skin lesions. [IMG-3]<br>Acne affects both sexes and all races.</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>",
      "order": 1,
      "disease_id": 2,
      "image_list": "[IMG-3]",
      "image_id": 3,
      "medicines": [],
      "created_at": "2022-09-27T06:54:43.000000Z",
      "updated_at": "2022-09-27T10:22:13.000000Z",
      "deleted_at": "2022-09-27T10:22:13.000000Z"
    },

  ];

}