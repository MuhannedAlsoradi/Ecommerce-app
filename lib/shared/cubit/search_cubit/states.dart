import 'package:salla_app/models/search_model.dart';

abstract class SearchStates {}

class InitSearchState extends SearchStates {}

class LoadingSearchState extends SearchStates {}

class SuccessSearchState extends SearchStates {
  final SearchModel searchModel;
  SuccessSearchState(this.searchModel);
}

class ErrorSearchState extends SearchStates {
  final String error;
  ErrorSearchState(this.error);
}
