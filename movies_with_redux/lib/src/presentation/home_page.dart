import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_with_redux/src/actions/see_all_movies.dart';
import 'package:movies_with_redux/src/actions/show_filters.dart';
import 'package:movies_with_redux/src/containers/is_loading_container.dart';
import 'package:movies_with_redux/src/containers/movies_container.dart';
import 'package:movies_with_redux/src/containers/see_all_container.dart';
import 'package:movies_with_redux/src/containers/show_filters_container.dart';
import 'package:movies_with_redux/src/models/app_state.dart';
import 'package:movies_with_redux/src/models/movie.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IsLoadingContainer(
      builder: (BuildContext context, bool isLoading) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: Text(
              'Yts Movies',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.orange[300],
          ),
          body: Builder(
            builder: (BuildContext context) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SeeAllContainer(
                builder: (BuildContext context, bool seeAll) {
                  return ShowFiltersContainer(
                    builder: (BuildContext context, bool showFilters) {
                      return MoviesContainer(
                        builder: (BuildContext context, BuiltList<Movie> movies) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Movies',
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (showFilters) {
                                              StoreProvider.of<AppState>(context).dispatch(HideFilters(true));
                                            } else {
                                              StoreProvider.of<AppState>(context).dispatch(ShowFilters(true));
                                            }
                                          },
                                          child: Icon(Icons.filter_alt_outlined),
                                        ),
                                        SizedBox(width: 8.0),
                                        GestureDetector(
                                          onTap: () {
                                            if (seeAll) {
                                              StoreProvider.of<AppState>(context).dispatch(SeeSomeMovies(true));
                                            } else {
                                              StoreProvider.of<AppState>(context).dispatch(SeeAllMovies(true));
                                            }
                                          },
                                          child: Text(
                                            seeAll ? 'See less' : 'See all',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (showFilters) ...<Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      TextField(
                                        decoration: InputDecoration(hintText: 'Minimum Rating'),
                                        onChanged: (String rating) {
                                          //StoreProvider.of(context).dispatch(FilterMoviesByRating());
                                          print(rating);
                                        },
                                      ),
                                      const SizedBox(height: 5.0),
                                      TextField(
                                        decoration: InputDecoration(hintText: 'Year'),
                                        onChanged: (String year) {
                                          print(year);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            print('Apply filters has been pressed');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'Apply Filters',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 8.0,
                                    crossAxisSpacing: 8.0,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: seeAll ? movies.length : 6,
                                  itemBuilder: (BuildContext context, int index) {
                                    final Movie movie = movies[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.orange[200],
                                        borderRadius: BorderRadius.circular(24.0),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            height: 125,
                                            width: 200,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(24.0),
                                              child: Image.network(
                                                movie.mediumCoverImage,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            '${movie.title}',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 4.0),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      '${movie.year}',
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'year',
                                                      style: TextStyle(color: Colors.grey[700]),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      '${movie.rating}',
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'rating',
                                                      style: TextStyle(
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
