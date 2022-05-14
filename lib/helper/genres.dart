import 'package:flutter/material.dart';

import 'constant.dart';
import 'genre_card.dart';

import 'package:popcorn/helper/Genre_model.dart' as genre;

class Genres extends StatelessWidget {
  List<genre.Genres> data;

  Genres({Key?key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<genre.Genres> genres = data;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) => GenreCard(genre: genres[index].name!),
      ),
    );
  }
}



