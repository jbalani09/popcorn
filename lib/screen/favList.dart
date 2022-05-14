import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../adapter/resultslocal.dart';
import '../helper/backgroud_image.dart';
import '../helper/constant.dart';
import '../helper/fade_widget.dart';
import '../helper/favCard.dart';

class FavList extends StatefulWidget {
  const FavList({Key? key}) : super(key: key);

  @override
  State<FavList> createState() => _FavListState();
}


final favMovies = Hive.box<ResultsLocal>('fav_movies');


class _FavListState extends State<FavList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0.0,
        leadingWidth: 40,
          leading: InkWell(onTap: (){
            Get.back();
          },child: Icon(Icons.arrow_back_ios_outlined,color: kSecondaryColor,)),
        ),
        body: ValueListenableBuilder(
            valueListenable: favMovies.listenable(),
            builder: (context, Box<ResultsLocal> box, _) {
            return (favMovies.length > 0)?SizedBox(
              height: gHeight,
              child: Stack(
                children: [
                  MainPic(),
                  const FadeWidget(),
                  FavCard(),
                ],
              ),
            ):const Center(
              child: Text("You Don't have Favourite Movies :)",style: TextStyle(color: Colors.grey),));
          }
        ),
      ),
    );;
  }
}


