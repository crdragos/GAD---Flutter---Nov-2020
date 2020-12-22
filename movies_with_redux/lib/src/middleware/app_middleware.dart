import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movies_with_redux/src/actions/filter_movies_by_rating.dart';
import 'package:movies_with_redux/src/actions/get_movies.dart';
import 'package:movies_with_redux/src/data/yts_api.dart';
import 'package:movies_with_redux/src/models/app_state.dart';
import 'package:movies_with_redux/src/models/movie.dart';
import 'package:redux/redux.dart';

class AppMiddleware {
  const AppMiddleware({@required YtsApi ytsApi})
      : assert(ytsApi != null),
        _ytsApi = ytsApi;

  final YtsApi _ytsApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      _getMovies,
      //_filterMoviesByRating,
    ];
  }

  Future<void> _getMovies(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is GetMovies) {
      try {
        final List<Movie> movies = await _ytsApi.getMovies();

        final GetMoviesSuccessful successful = GetMoviesSuccessful(movies);

        store.dispatch(successful);
      } catch (e) {
        final GetMoviesError error = GetMoviesError(e);
        store.dispatch(error);
      }
    }
  }

  // Future<void> _filterMoviesByRating(Store<AppState> store, dynamic action, NextDispatcher next) async {
  //   next(action);
  //   if (action is FilterMoviesByRating) {
  //     try {
  //       final List<Movie> filteredMovies = await _ytsApi.filterMoviesByRating(minimumRating);
  //
  //       final FilterMoviesByRatingSuccessful successful = FilterMoviesByRatingSuccessful(filteredMovies);
  //
  //       store.dispatch(successful);
  //     } catch (e) {
  //       final FilterMoviesByRatingError error = FilterMoviesByRatingError(e);
  //
  //       store.dispatch(error);
  //     }
  //   }
  // }
}
