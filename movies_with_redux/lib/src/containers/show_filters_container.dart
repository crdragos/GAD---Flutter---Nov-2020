import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_with_redux/src/models/app_state.dart';
import 'package:redux/redux.dart';

class ShowFiltersContainer extends StatelessWidget {
  const ShowFiltersContainer({Key key, @required this.builder}) : super(key: key);

  final ViewModelBuilder<bool> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) {
        return store.state.showFilters;
      },
      builder: builder,
    );
  }

}
