import 'package:movies_with_redux/src/actions/filter_movies_by_rating.dart';
import 'package:movies_with_redux/src/actions/get_movies.dart';
import 'package:movies_with_redux/src/actions/see_all_movies.dart';
import 'package:movies_with_redux/src/actions/show_filters.dart';
import 'package:movies_with_redux/src/models/app_state.dart';

AppState reducer(AppState state, dynamic action) {
  print('action: $action');
  final AppStateBuilder builder = state.toBuilder();

  if (action is GetMovies) {
    builder.isLoading = true;
  } else if (action is GetMoviesSuccessful) {
    builder.movies.addAll(action.movies);
    builder.isLoading = false;
  } else if (action is GetMoviesError) {
    builder.isLoading = false;
  } else if (action is SeeAllMovies) {
    builder.seeAll = true;
  } else if (action is SeeSomeMovies) {
    builder.seeAll = false;
  } else if (action is ShowFilters) {
    builder.showFilters = true;
  } else if (action is HideFilters) {
    builder.showFilters = false;
  } else if (action is FilterMoviesByRating) {
    builder.isLoading = true;
  } else if (action is FilterMoviesByRatingSuccessful) {
    builder.movies.addAll(action.filteredMovies);
    builder.isLoading = false;
  } else if (action is FilterMoviesByRatingError) {
    builder.isLoading = false;
  }

  return builder.build();
}
