import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_with_redux/src/models/app_state.dart';
import 'package:redux/redux.dart';

class SeeAllContainer extends StatelessWidget {
  const SeeAllContainer({Key key, @required this.builder}) : super(key: key);

  final ViewModelBuilder<bool> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (Store<AppState> store) {
        return store.state.seeAll;
      },
      builder: builder,
    );
  }

}