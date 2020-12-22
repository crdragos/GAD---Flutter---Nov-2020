import 'package:movies_with_redux/src/models/movie.dart';

class FilterMoviesByRating {
  const FilterMoviesByRating();
}

class FilterMoviesByRatingSuccessful {
  const FilterMoviesByRatingSuccessful(this.filteredMovies);

  final List<Movie> filteredMovies;
}

class FilterMoviesByRatingError {
  const FilterMoviesByRatingError(this.error);

  final dynamic error;
}