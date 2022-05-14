import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

import '../helper/constant.dart';



Map<String, String> buildHeaderTokens() {
  Map<String, String> header = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    HttpHeaders.cacheControlHeader: 'no-cache',
    HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Origin': '*',
  };
  log(jsonEncode(header));
  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('$sBaseUrl$endPoint');

  log('URL: ${url.toString()}');

  return url;
}

Future<Response> buildHttpResponse(String endPoint,
    {HttpMethod method = HttpMethod.GET, required Map request}) async {
  if (await isNetworkAvailable()) {
    var headers = buildHeaderTokens();
    Uri url = buildBaseUrl(endPoint);

    Response response;

    try {
      if (method == HttpMethod.POST) {
        log('Request: $request');

        response =
        await http.post(url, body: jsonEncode(request), headers: headers);
      } else if (method == HttpMethod.DELETE) {
        response = await delete(url, headers: headers);
      } else if (method == HttpMethod.PUT) {
        response = await put(url, body: jsonEncode(request), headers: headers);
      } else {
        response = await get(url, headers: headers);
      }

      log('RESPONSE: $response');
      log('RESPONSE BODY: ${response.body}');
      if (response.statusCode == 422) {
        print(jsonDecode(response.body));
      }

      return response;
    } catch (e) {
      if (e is SocketException) {
        throw "Seems like your internet is not working or server is not reachable.";
      } else if (e is TimeoutException) {
        throw "Seems like your internet is not working or server is not reachable .";
      } else {
        throw "Seems like your internet is not working or server is not reachable";
      }
    }
  } else {
    throw "Please check your internet and try again.";
  }
}

Future handleResponse(Response response, [avoidTokenError]) async {
  if (!await isNetworkAvailable()) {
    throw "Please check your internet and try again.";
  }
  var json = jsonDecode(response.body);
  if (response.statusCode.isSuccessful() && !(json.containsKey('errors')) ) {
    return jsonDecode(response.body);
  } else {
    if (response.body.isJson()) {
      if (json.containsKey('errors')) {
        String errorMessages = "";
        json["errors"].forEach((key, messages) {
          for (var message in messages) errorMessages += "$message\n";
        });
        throw errorMessages.toString();
      }else{
        String errorMessages = json["message"];
        throw errorMessages.toString();
      }
    } else {
      try {
        var body = jsonDecode(response.body);
        throw body['message'];
      } on Exception catch (e) {
        log(e);
        throw errorSomethingWentWrong;
      }
    }
  }
}




enum HttpMethod { GET, POST, DELETE, PUT }