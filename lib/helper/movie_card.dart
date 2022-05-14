import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:popcorn/screen/base_view/model/companies_model.dart';
import 'package:animations/animations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../screen/base_view/controller/base_view_controller.dart';
import '../screen/movie_detail_screen/view/movie_detail_screen.dart';
import 'constant.dart';


class MovieCard extends StatelessWidget {
  MovieCard({
    Key? key,
    required BaseViewController con,
    required int indexTo
  }) : _con = con, index = indexTo,super(key: key);

  final BaseViewController _con;
  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                  movieId: _con.moviesToShow[index].id!),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Stack(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.black87,
                    highlightColor: Colors.white54,
                    enabled: true,
                    child: SizedBox(
                      height: gHeight * 0.34,
                      child: const AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Icon(
                            Icons.fastfood_rounded,
                            color: Colors.grey,
                            size: 60.0,
                          )),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: kSecondaryColor
                        ),
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Column(
                      children: [
                        8.height,
                        Container(
                          height: gHeight * 0.28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [kDefaultShadow],
                          ),
                          child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    placeholder: kTransparentImage,
                                    image: imageBaseUrl +
                                        _con.moviesToShow[index].posterPath!),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                          child: Text(
                            _con.moviesToShow[index].title!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w300,color: kTextLightColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "${_con.moviesToShow[index].releaseDate}",
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kTextLightColor),
                              ),
                              TextIcon(
                                prefix: const Icon(Icons.remove_red_eye,color: Colors.amberAccent,size: 20,),
                                text: "${ _con.moviesToShow[index].voteCount}",
                                textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: kTextLightColor),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
