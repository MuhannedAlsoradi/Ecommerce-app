import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/models/search_model.dart';
import 'package:salla_app/shared/components/constants.dart';
import 'package:salla_app/shared/cubit/search_cubit/states.dart';
import 'package:salla_app/shared/network/end_points.dart';
import 'package:salla_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitSearchState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  void searchGetData({required String value}) {
    emit(LoadingSearchState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {'text': value},
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchState(searchModel!));
    }).catchError((error) {
      print(error);
      emit(ErrorSearchState(error.toString()));
    });
  }
}
