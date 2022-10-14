import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/shared/cubit/theme_cubit/states.dart';
import 'package:salla_app/shared/network/local/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(InitChangeThemeModeState());
  bool isDark = false;
  static ThemeCubit get(context) => BlocProvider.of(context);
  void changeAppTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeModeState());
      });
    }
  }
}
