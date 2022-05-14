import 'package:flutter/material.dart';
import 'package:popcorn/screen/base_view/model/companies_model.dart';

import 'constant.dart';
import 'movie_card.dart';

import 'dart:math';

class MovieCarousel extends StatefulWidget {

  List<Results> movie;

  MovieCarousel({Key?key, required this.movie}) : super(key: key);

  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  late PageController _pageController;
  int initialPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      // so that we can have small portion shown on left and right side
      viewportFraction: 0.8,
      // by default our movie poster
      initialPage: initialPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: AspectRatio(
        aspectRatio: 0.85,
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              initialPage = value;
            });
          },
          controller: _pageController,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.movie.length,
          itemBuilder: (context, index) => buildMovieSlider(index),
        ),
      ),
    );
  }

  Widget buildMovieSlider(int index) => AnimatedBuilder(
    animation: _pageController,
    builder: (context, child) {
      num value = 0;
      if (_pageController.position.haveDimensions) {
        value = index - _pageController.page!;
        // We use 0.038 because 180*0.038 = 7 almost and we need to rotate our poster 7 degree
        // we use clamp so that our value vary from -1 to 1
        value = (value * 0.038).clamp(-1, 1);
      }
      return AnimatedOpacity(
        duration: Duration(milliseconds: 350),
        opacity: initialPage == index ? 1 : 0.4,
        child: Transform.rotate(
          angle: pi * value,
          child: Container()
          // MovieCard(movie: widget.movie[index]),
        ),
      );
    },
  );
}