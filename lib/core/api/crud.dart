import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:test/core/api/status_request.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusFailureRequest, Map>> postData(
      String url, Map data) async {
    http.Response response = await http.post(Uri.parse(url), body: data);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map dataResponse = jsonDecode(response.body);
      if (dataResponse["status"] != "success") {
        return const Left(StatusFailureRequest.noData);
      } else {
        return Right(dataResponse);
      }
    } else {
      return const Left(StatusFailureRequest.severFailure);
    }
  }

  Future<Either<StatusFailureRequest, Map>> getData(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map dataResponse = jsonDecode(response.body);
      return Right(dataResponse);
    } else {
      return const Left(StatusFailureRequest.severFailure);
    }
  }
}
