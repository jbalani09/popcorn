import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popcorn/helper/constant.dart';
import 'package:popcorn/main.dart';
import 'package:transparent_image/transparent_image.dart';

import '../screen/base_view/controller/animation_controller.dart';
import 'cart_controller.dart';

class MainPic extends StatelessWidget {
  //...
  final _cardController = Get.find<CardController>();
  var _animeController = Get.find<ControllerAnimation>();
  //...
  @override
  Widget build(BuildContext context) {
    Get.find<ControllerAnimation>().runAnime();
    return Obx(
          () {
        return FadeTransition(
          opacity: _animeController.opacityAnime,
          child: ScaleTransition(
            scale: _animeController.scaleAnime,
            child: SizedBox(
              width: gWidth,
              height: gHeight/1.6,
              child: Hero(
                tag: _cardController.currentIndex.value,
                child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: "Please Wait",
                      image: imageBaseUrl + Get.find<CardController>()
                          .listOfMovies[_cardController.currentIndex.value]
                          .backdropPath!)
              ),
            ),
          ),
        );
      },
    );
  }
}
