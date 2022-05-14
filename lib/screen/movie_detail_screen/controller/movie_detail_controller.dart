import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:popcorn/screen/movie_detail_screen/model/movie_detail_model.dart';

import '../../../helper/constant.dart';
import '../../../main.dart';
import '../../../networks/network_utils.dart';

import 'package:http/http.dart' as http;

class MovieDetailController extends GetxController{

  var model = MovieDetailModel().obs;

  Future getMovieDetail(var movieId) async {
    appStore.isLoading.value = true;
    await getMovieDetailReq(movieId).then((value) async {
      appStore.isLoading.value =  false;
      model.value = value;
      appStore.isLoading.value = true;
    }).catchError((e) {
      appStore.isLoading.value = false;
      //toast(e.toString());
      log(e);
    });
    return model;
  }

  Future<MovieDetailModel> getMovieDetailReq(int id) async {
    http.Response response = await buildHttpResponse('movie/$id?api_key=0e7274f05c36db12cbe71d9ab0393d47',
        request: {}, method: HttpMethod.GET);
    return await handleResponse(response).then((json) async {
      var featuredProducts = MovieDetailModel.fromJson(json);
      return featuredProducts;
    }).catchError((e) {
      toast(e.toString());
    });
  }

  Padding AboutMovieRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              10.width,
              Text(value,
                  style: const TextStyle(
                      fontSize: 14.0,
                      color: kSecondaryColor
                  ))
            ],
          ),
        ],
      ),
    );
  }

}