import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:popcorn/screen/movie_detail_screen/view/movie_detail_screen.dart';

import '../adapter/resultslocal.dart';
import 'cart_controller.dart';
import 'constant.dart';

class FavCard extends StatelessWidget {
  final CarouselController _carouselController = CarouselController();
  final _cardController = Get.find<CardController>();

  final favMovies = Hive.box<ResultsLocal>('fav_movies');

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      height: gHeight * 0.7,
      width: gWidth,
      child: ValueListenableBuilder(
          valueListenable: favMovies.listenable(),
          builder: (context, Box<ResultsLocal> box, _) {
          return CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
                height: gHeight / 1.6,
                aspectRatio: 16 / 9,
                viewportFraction: 0.75,
                enlargeCenterPage: true,
                onPageChanged: (index, _) {
                  _cardController.changeIndex(index);
                }),
            items: _cardController.listOfMovies.map(
                  (movie) {
                return Builder(
                  builder: (ctx) {
                    return InkWell(
                      onTap: (){
                        MovieDetailScreen(movieId: movie.id!,).launch(context);
                      },
                      child: Container(
                        width: gWidth,
                        decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                height: 200,
                                width: gWidth,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.network(
                                  imageBaseUrl + movie.backdropPath!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                movie.title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                movie.voteCount.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                movie.voteAvg.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          );
        }
      ),
    );
  }
}