import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:popcorn/helper/cart_controller.dart';
import 'package:popcorn/helper/constant.dart';
import 'package:popcorn/screen/movie_detail_screen/controller/movie_detail_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../adapter/resultslocal.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen(
      {Key? key,
      required this.movieId,})
      : super(key: key);
  final num movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();

}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  final _con = Get.put(MovieDetailController());
  final favMovies = Hive.box<ResultsLocal>('fav_movies');

  Rx<ResultsLocal> local = ResultsLocal().obs;

  final _cardController = Get.find<CardController>();

  @override
  void initState() {
    _con.getMovieDetail(widget.movieId).then((value) {
      local.value = ResultsLocal(
          id: _con.model.value.id,
          backdropPath: _con.model.value.backdropPath,
          voteAvg: _con.model.value.voteAverage,
          voteCount: _con.model.value.voteCount,
          title: _con.model.value.title,
          poster: _con.model.value.posterPath
      );
      print("LOCAL VALIDATION" + favMovies.values.toString());
      // for(int i = 0; i<=favMovies.length-1;i++){
        print("FavMovies" + favMovies.values.where((item) => (item.title == _con.model.value.title!)).isNotEmpty.toString());
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Obx(
          () {
            return (_con.model.value.title != null)?ListView(
              padding: EdgeInsets.zero,
              controller: ScrollController(),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.white54,
                            child: AspectRatio(
                                aspectRatio: 3 / 2,
                                child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                    ))),
                          ),
                          AspectRatio(
                              aspectRatio: 3 / 2,
                              child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: kTransparentImage,
                                  image: imageBaseUrl +
                                      _con.model.value.backdropPath!)),
                        ],
                      ),
                      AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.2),
                                Colors.black.withOpacity(1.0)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0, 1],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0.0,
                          left: 10.0,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.white10,
                                      highlightColor: Colors.white30,
                                      enabled: true,
                                      child: SizedBox(
                                        height: 120.0,
                                        child: AspectRatio(
                                            aspectRatio: 2 / 3,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                  color: Colors.black12,
                                                ))),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0)),
                                      height: 120.0,
                                      child: AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(5.0),
                                            child: FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image:
                                                imageBaseUrl +
                                                    _con.model.value.posterPath!),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 140,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        _con.model.value.title!,
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Release date: " +
                                                _con.model.value.releaseDate!,
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w200),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                        left: 5.0,
                        child: SafeArea(
                            child: SizedBox(
                              width: gWidth,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: backgroundColor,
                                        shape: BoxShape.circle
                                      ),
                                      child: Center(
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.arrow_back_ios_outlined,
                                              size: 25.0,
                                              color: kSecondaryColor,
                                            )),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: backgroundColor,
                                          shape: BoxShape.circle
                                      ),
                                      child: Center(
                                        child: IconButton(
                                            onPressed: () {
                                              var termKey = 0;
                                              favMovies.toMap().forEach((key, value){
                                                if (value.id == _con.model.value.id) {
                                                  termKey = key;
                                                }
                                              });
                                              favMovies.values.where((item) => (item.title == _con.model.value.title!)).isNotEmpty?favMovies.delete(termKey):favMovies.add(local.value);
                                             //  favMovies.clear();
                                              _cardController.listOfMovies.value = favMovies.values.toList();
                                            },
                                            icon:  ValueListenableBuilder(
                                                valueListenable: favMovies.listenable(),
                                                builder: (context, Box<ResultsLocal> box, _) {
                                                return Icon(
                                                      favMovies.values.where((item) => (item.title == _con.model.value.title!)).isNotEmpty?Icons.favorite:Icons.favorite_border,
                                                          size: 25.0,
                                                          color: kSecondaryColor,
                                                        );
                                              }
                                            )
                                             ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.lock_clock,
                            size: 15.0,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            _con.model.value.releaseDate!,
                            style: const TextStyle(
                                fontSize: 11.0, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 40.0,
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _con.model.value.genres!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(30.0)),
                                            color: Colors.white.withOpacity(0.1)),
                                        child: Text(
                                          _con.model.value.genres![index].name!,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              height: 1.4,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 9.0),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                     20.height,
                      Text("Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white.withOpacity(0.5))),
                      10.height,
                      Text(_con.model.value.title.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                            fontSize: 14.0,
                          )),
                    ],
                  ),
                ),
                10.height,
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.05)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("OVERVIEW",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white.withOpacity(0.5))),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(_con.model.value.overview!,
                          style: const TextStyle(
                              height: 1.5,
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text("ABOUT MOVIE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white.withOpacity(0.5))),
                    ],
                  ),
                ),
                10.height,
                _con.AboutMovieRow("status",_con.model.value.status!),
                10.height,
                _con.AboutMovieRow("tagline",_con.model.value.tagline!),
                10.height,
                _con.AboutMovieRow("spoken language",_con.model.value.originalLanguage!),
                10.height,
                _con.AboutMovieRow("rating",_con.model.value.voteAverage.toString()),
              ],
            ):const Center(child: AspectRatio(
            aspectRatio: 2 / 3,
            child: Icon(
            Icons.fastfood_rounded,
            color: Colors.black26,
                size: 60.0,
            )));
          }
        ),),
    );
  }
}
