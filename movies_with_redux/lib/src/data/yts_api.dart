import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:movies_with_redux/src/models/movie.dart';

class YtsApi {
  const YtsApi({@required Client client})
      : assert(client != null),
        _client = client;

  final Client _client;

  Future<List<Movie>> getMovies() async {
    const String url = 'https://yts.mx/api/v2/list_movies.json?limit=50';

    final Response response = await _client.get(url);
    final String body = response.body;
    final List<dynamic> list = jsonDecode(body)['data']['movies'];
    return list //
        .map((dynamic json) => Movie.fromJson(json))
        .toList();
  }

  Future<List<Movie>> filterMoviesByRating(num minimumRating) async {
    const String url = 'https://yts.mx/api/v2/list_movies.json?limit=50';

    final Response response = await _client.get(url);

    final List<String> moviesString = response.body.split('{"id":');
    final List<Movie> filteredMovies = <Movie>[];

    for (final String movie in moviesString.skip(1)) {
      const String startRatingPattern = '"rating":';
      const String endRatingPattern = ',"runtime":';
      final num rating = num.tryParse(movie.substring(
          movie.indexOf(startRatingPattern) + startRatingPattern.length, movie.indexOf(endRatingPattern)));

      if (minimumRating <= rating) {
        const String startTitlePattern = '"title":"';
        const String endTitlePattern = '","title_english":"';
        final String title = movie.substring(
            movie.indexOf(startTitlePattern) + startTitlePattern.length, movie.indexOf(endTitlePattern));

        const String startYearPattern = '"year":';
        const String endYearPattern = ',"rating":';
        final int year = int.tryParse(
            movie.substring(movie.indexOf(startYearPattern) + startYearPattern.length, movie.indexOf(endYearPattern)));

        const String startRuntimePattern = '"runtime":';
        const String endRuntimePattern = ',"genres":';
        final num runtime = num.tryParse(movie.substring(
            movie.indexOf(startRuntimePattern) + startRuntimePattern.length, movie.indexOf(endRuntimePattern)));

        const String startGenresPattern = '"genres":["';
        const String endGenresPattern = '"],"summary"';
        final List<String> genres = movie
            .substring(movie.indexOf(startGenresPattern) + startGenresPattern.length, movie.indexOf(endGenresPattern))
            .split('","');

        const String startSummaryPattern = '"summary":"';
        const String endSummaryPattern = '","description_full"';
        final String summary = movie.substring(
            movie.indexOf(startSummaryPattern) + startSummaryPattern.length, movie.indexOf(endSummaryPattern));

        const String startBackgroundImagePattern = '"background_image":"';
        const String endBackgroundImagePattern = '","background_image_original"';
        final String backgoundImage = movie.substring(
            movie.indexOf(startBackgroundImagePattern) + startBackgroundImagePattern.length,
            movie.indexOf(endBackgroundImagePattern));

        const String startMediumCoverImagePattern = '"medium_cover_image": "';
        const String endMediumCoverImagePattern = '","large_cover_image":';
        final String mediumCoverImage = movie.substring(
            movie.indexOf(startMediumCoverImagePattern) + startMediumCoverImagePattern.length,
            movie.indexOf(endMediumCoverImagePattern));

        const String startLargeCoverImagePattern = '"large_cover_image": "';
        const String endLargeCoverImagePattern = '","state":';
        final String largeCoverImage = movie.substring(
            movie.indexOf(startLargeCoverImagePattern) + startLargeCoverImagePattern.length,
            movie.indexOf(endLargeCoverImagePattern));

        filteredMovies.add(Movie.fromFiltering(title, year, rating, runtime, genres, summary, backgoundImage, mediumCoverImage, largeCoverImage));
      }
    }

    return filteredMovies;
  }
}
