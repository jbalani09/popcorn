import 'package:flutter/material.dart';

import 'constant.dart';

class GenreCard extends StatelessWidget {
  final String genre;

  const GenreCard({Key ?key, required this.genre}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: kDefaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 4, // 5 padding top and bottom
      ),
      decoration: BoxDecoration(
        border: Border.all(color: kSecondaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        genre,
        style: TextStyle(color: kTextLightColor.withOpacity(0.8), fontSize: 16),
      ),
    );
  }
}