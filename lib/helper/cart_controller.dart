

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:popcorn/adapter/resultslocal.dart';
import 'package:popcorn/screen/base_view/model/companies_model.dart';

import 'movies.dart';

class CardController extends GetxController {


  RxList<ResultsLocal> listOfMovies = <ResultsLocal>[].obs;

  var currentIndex = 0.obs;


  void changeIndex(int index) {
    currentIndex.value = index;
  }
}