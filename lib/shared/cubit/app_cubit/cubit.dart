import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/models/category_model.dart';
import 'package:salla_app/models/favorites_get_model.dart';
import 'package:salla_app/models/favorites_post_model.dart';
import 'package:salla_app/models/home_model.dart';
import 'package:salla_app/models/login_model.dart';
import 'package:salla_app/modules/categories_screen.dart';
import 'package:salla_app/modules/favorites_screen.dart';
import 'package:salla_app/modules/home_screen.dart';
import 'package:salla_app/modules/settings_screen.dart';
import 'package:salla_app/shared/components/constants.dart';
import 'package:salla_app/shared/cubit/app_cubit/states.dart';
import 'package:salla_app/shared/network/end_points.dart';
import 'package:salla_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int screenIndex = 0;

  List<Widget> bottomScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];
  void changeIndex(int index) {
    screenIndex = index;
    emit(AppBottomNavBarState());
  }

  int activeIndex = 0;
  void changeCarouselIndex(int index) {
    activeIndex = index;
    emit(AppCarouselSlider());
  }

  Map<int, bool> favorites = {};
  HomeModel? homeModel;
  void getHomeData() {
    emit(HomeDataLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach(
        (product) {
          favorites.addAll({product.id: product.inFavorites});
        },
      );
      emit(HomeDataSuccessState());
    }).catchError((error) {
      print(error);
      emit(HomeDataErrorState(error));
    });
  }

  CategoryModel? categoryModel;
  void getCategory() {
    DioHelper.getData(
      url: CATEGORY,
      token: token,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print(categoryModel!.status);
      emit(CategoryDataSuccessState());
    }).catchError((error) {
      print(error);
      emit(CategoryDataErrorState(error));
    });
  }

  FavoritesModel? favoritesModel;
  void changeFavModel(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(FavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      if (!favoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        favGetDataModel();
      }
      emit(FavoritesDataSuccessState(favoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(FavGetDataErrorState(error));
    });
  }

  FavGetModel? favGetModel;
  void favGetDataModel() {
    emit(FavGetDataLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favGetModel = FavGetModel.fromJson(value.data);
      emit(FavGetDataSuccessState());
    }).catchError((error) {
      emit(FavGetDataErrorState(error));
    });
  }

  LoginModel? model;
  void GetUserDataModel() {
    emit(UserGetDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      model = LoginModel.fromJson(value.data);
      emit(UserGetDataSuccessState(model!));
    }).catchError((error) {
      emit(UserGetDataErrorState(error));
    });
  }

  LoginModel? updateProfile;
  void updateUserDataModel({
    required String email,
    required String name,
    required String phone,
    required String image,
  }) {
    emit(UserUpdateDataLoadingState());
    DioHelper.puData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'email': email,
        'phone': phone,
        'name': name,
        'image': image,
      },
    ).then((value) {
      model = LoginModel.fromJson(value.data);
      emit(UserUpdateDataSuccessState(model!));
    }).catchError((error) {
      emit(UserUpdateDataErrorState(error));
    });
  }
}
