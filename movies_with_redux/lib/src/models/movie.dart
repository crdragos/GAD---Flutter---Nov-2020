library movie;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:movies_with_redux/src/models/serializers.dart';

part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {
  factory Movie([void Function(MovieBuilder) updates]) = _$Movie;

  factory Movie.fromJson(dynamic json) {
    return serializers.deserializeWith(serializer, json);
  }

  factory Movie.fromFiltering(String title, int year, num rating, int runtime, List<String> genres, String summary, String backgroundImage, String mediumCoverImage, String largeCoverImage) {
    final MovieBuilder builder = MovieBuilder();
    builder.title = title;
    builder.year = year;
    builder.rating = rating;
    builder.runtime = runtime;
    builder.genres = genres as ListBuilder<String>;
    builder.summary = summary;
    builder.backgroundImage = backgroundImage;
    builder.mediumCoverImage = mediumCoverImage;
    builder.largeCoverImage = largeCoverImage;
    return builder.build();
  }

  Movie._();

  String get title;

  int get year;

  num get rating;

  int get runtime;

  BuiltList<String> get genres;

  String get summary;

  @BuiltValueField(wireName: 'background_image')
  String get backgroundImage;

  @BuiltValueField(wireName: 'medium_cover_image')
  String get mediumCoverImage;

  @BuiltValueField(wireName: 'large_cover_image')
  String get largeCoverImage;

  static Serializer<Movie> get serializer => _$movieSerializer;
}
