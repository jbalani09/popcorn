

import 'package:hive/hive.dart';

part 'resultslocal.g.dart';

@HiveType(typeId: 2)
class ResultsLocal extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? backdropPath;

  @HiveField(2)
  String? poster;

  @HiveField(3)
  num? id;

  @HiveField(4)
  num? voteAvg;

  @HiveField(5)
   num? voteCount;

  ResultsLocal({ this.voteAvg,
     this.backdropPath,
     this.voteCount,
     this.id,
     this.title,
    this.poster
    });
}