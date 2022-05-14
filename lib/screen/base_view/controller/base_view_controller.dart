

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:http/http.dart' as http;
import 'package:popcorn/helper/Genre_model.dart' as genre;
import '../../../adapter/resultslocal.dart';
import '../../../helper/cart_controller.dart';
import '../../../helper/constant.dart';
import '../../../main.dart';
import '../../../networks/network_utils.dart';
import '../model/companies_model.dart';
import '../view/base_view.dart';

class BaseViewController extends GetxController{

  final _cardController = Get.find<CardController>();

  var nowPlayingListPage = 1.obs;
  var topRatedListPage = 1.obs;
  var popularListPage = 1.obs;

  RxList<Results> nowPlayingMovies = <Results>[].obs;

  RxList<genre.Genres> genres = <genre.Genres>[].obs;

  RxList<Results> popularMovies = <Results>[].obs;

  RxList<Results> topRatedMovies = <Results>[].obs;

  RxList<Results> moviesToShow = <Results>[].obs;

  var selectedCategory = 0.obs;

  List<String> categories = ["Now Playing", "Popular", "Top Rated"];

  final favMovies = Hive.box<ResultsLocal>('fav_movies');

  Future getNowPlayingMovies() async {
      appStore.isLoading.value = true;
      await getNowPlayingMoviesReq(nowPlayingListPage.value).then((value) async {
        appStore.isLoading.value =  false;
        (nowPlayingListPage.value>1)?nowPlayingMovies.value+=value.results!:nowPlayingMovies.value = value.results!;
        (nowPlayingListPage.value>1)?moviesToShow += value.results!:null;
        _cardController.listOfMovies.value = favMovies.values.toList();
      }).catchError((e) {
        appStore.isLoading.value = false;
        //toast(e.toString());
        log(e);
      });
      return nowPlayingMovies;
  }

  Future<MoviesResponse> getNowPlayingMoviesReq(int page) async {
    http.Response response = await buildHttpResponse('movie/now_playing?page=$page&api_key=$apiKey',
        request: {}, method: HttpMethod.GET);
    return await handleResponse(response).then((json) async {
      var movies = MoviesResponse.fromJson(json);
      return movies;
    }).catchError((e) {
      toast(e.toString());
    });
  }


  Future getGenreList() async {
    appStore.isLoading.value = true;
    await getGenreListReq().then((value) async {
      appStore.isLoading.value =  false;
      genres.value = value.genres!;
      // _cardController.listOfMovies.value = value.genres!;
    }).catchError((e) {
      appStore.isLoading.value = false;
      //toast(e.toString());
      log(e);
    });
    return nowPlayingMovies;
  }

  Future<genre.GenreModel> getGenreListReq() async {
    http.Response response = await buildHttpResponse('genre/movie/list?api_key=$apiKey',
        request: {}, method: HttpMethod.GET);
    return await handleResponse(response).then((json) async {
      var movies = genre.GenreModel.fromJson(json);
      return movies;
    }).catchError((e) {
      toast(e.toString());
    });
  }

  Future getPopularMovies() async {
    appStore.isLoading.value = true;
    await getPopularMoviesReq(popularListPage.value).then((value) async {
      appStore.isLoading.value =  false;
      (popularListPage.value>1)?popularMovies.value+=value.results!:popularMovies.value = value.results!;
      (popularListPage.value>1)?moviesToShow += value.results!:null;
    }).catchError((e) {
      appStore.isLoading.value = false;
      //toast(e.toString());
      log(e);
    });
    return popularMovies;
  }

  Future<MoviesResponse> getPopularMoviesReq(int page) async {
    http.Response response = await buildHttpResponse('movie/popular?page=$popularListPage&api_key=$apiKey',
        request: {}, method: HttpMethod.GET);
    return await handleResponse(response).then((json) async {
      var movies = MoviesResponse.fromJson(json);
      return movies;
    }).catchError((e) {
      toast(e.toString());
    });
  }

  Future getTopRatedMovies() async {
    appStore.isLoading.value = true;
    await getTopRatedMoviesReq(topRatedListPage.value).then((value) async {
      appStore.isLoading.value =  false;
      (topRatedListPage.value>1)?topRatedMovies.value+=value.results!:topRatedMovies.value = value.results!;
      (topRatedListPage.value>1)?moviesToShow += value.results!:null;
    }).catchError((e) {
      appStore.isLoading.value = false;
      //toast(e.toString());
      log(e);
    });
    return topRatedMovies;
  }

  Future<MoviesResponse> getTopRatedMoviesReq(int page) async {
    http.Response response = await buildHttpResponse('movie/top_rated?page=$page&api_key=0e7274f05c36db12cbe71d9ab0393d47',
        request: {}, method: HttpMethod.GET);
    return await handleResponse(response).then((json) async {
      var movies = MoviesResponse.fromJson(json);
      return movies;
    }).catchError((e) {
      toast(e.toString());
    });
  }

}