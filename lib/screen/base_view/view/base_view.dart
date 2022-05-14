import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:popcorn/adapter/resultslocal.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../helper/constant.dart';
import '../../../helper/genre_card.dart';
import '../../../helper/movie_card.dart';
import '../../favList.dart';
import '../../movie_detail_screen/view/movie_detail_screen.dart';
import '../controller/base_view_controller.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}


class _BaseViewState extends State<BaseView> {

  final _con = Get.put(BaseViewController());

  final  _scrollController = ScrollController();

  @override
  void initState() {
    _con.getNowPlayingMovies().then((value) {
      _con.moviesToShow.value = value;
    });
    _con.getGenreList();
    _con.getPopularMovies();
    _con.getTopRatedMovies();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if(_con.selectedCategory.value == 0) {
          _con.nowPlayingListPage.value += 1;
          _con.getNowPlayingMovies();
        }else if(_con.selectedCategory.value == 1){
          _con.popularListPage.value += 1;
          _con.getPopularMovies();
        }else{
          _con.topRatedListPage+=1;
          _con.getTopRatedMovies();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavList(),));
              },
              child: const Icon(Icons.favorite,color: kSecondaryColor,size: 50,)),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
           children: <Widget>[
           Container(
                    margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _con.categories.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Obx(() {
                            return GestureDetector(
                              onTap: () {
                                  _con.selectedCategory.value = index;
                                  (index == 1)?{
                                    _con.moviesToShow.value = _con.popularMovies
                                  }:null;
                                  (index == 0)?{
                                    _con.moviesToShow.value = _con.nowPlayingMovies
                                  }:null;
                                  (index == 2)?{
                                    _con.moviesToShow.value = _con.topRatedMovies
                                  }:null;
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _con.categories[index],
                                    style: Theme.of(context).textTheme.headline5!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: index == _con.selectedCategory.value
                                          ? kSecondaryColor
                                          : kTextLightColor,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                                    height: 6,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: index == _con.selectedCategory.value
                                          ? kSecondaryColor
                                          : Colors.transparent,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        ),
                      ),
                    ),
                  ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              height: 36,
              child: Obx(
                () {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _con.genres.length,
                    itemBuilder: (context, index) => GenreCard(genre: _con.genres[index].name!),
                  );
                }
              ),
            ),
            Obx(() {
                return Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: StaggeredGrid.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            children: List.generate(
                              _con.moviesToShow.length,
                                  (index) {
                                 print("ID :" +  _con.moviesToShow[index].id.toString());
                                return MovieCard(con: _con,indexTo: index,);
                              },
                            ),
                          ),
                        );
              }
            )
            ],
          ),
        ),
      ),
    );
  }
}


