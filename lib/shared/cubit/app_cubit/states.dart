import 'package:salla_app/models/favorites_post_model.dart';
import 'package:salla_app/models/login_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppBottomNavBarState extends AppStates {}

class AppCarouselSlider extends AppStates {}

class HomeDataSuccessState extends AppStates {}

class HomeDataLoadingState extends AppStates {}

class HomeDataErrorState extends AppStates {
  final error;
  HomeDataErrorState(this.error);
}

class CategoryDataSuccessState extends AppStates {}

class CategoryDataErrorState extends AppStates {
  final error;
  CategoryDataErrorState(this.error);
}

class FavoritesDataSuccessState extends AppStates {
  final FavoritesModel model;
  FavoritesDataSuccessState(this.model);
}

class FavoritesState extends AppStates {}

class FavoritesDataErrorState extends AppStates {
  final error;
  FavoritesDataErrorState(this.error);
}

class FavGetDataSuccessState extends AppStates {}

class FavGetDataErrorState extends AppStates {
  final error;
  FavGetDataErrorState(this.error);
}

class FavGetDataLoadingState extends AppStates {}

class UserGetDataSuccessState extends AppStates {
  final LoginModel loginModel;

  UserGetDataSuccessState(this.loginModel);
}

class UserGetDataErrorState extends AppStates {
  final error;
  UserGetDataErrorState(this.error);
}

class UserUpdateDataLoadingState extends AppStates {}

class UserUpdateDataSuccessState extends AppStates {
  final LoginModel updateModel;

  UserUpdateDataSuccessState(this.updateModel);
}

class UserUpdateDataErrorState extends AppStates {
  final error;
  UserUpdateDataErrorState(this.error);
}

class UserGetDataLoadingState extends AppStates {}
