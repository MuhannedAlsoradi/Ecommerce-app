import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/models/login_model.dart';
import 'package:salla_app/shared/cubit/login_cubit/states.dart';
import 'package:salla_app/shared/network/end_points.dart';
import 'package:salla_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData iconData = Icons.visibility_off_outlined;
  late LoginModel loginModel;
// post login data
  void loginData({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.message.toString());
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

// obscured text method ...
  void changeObscured() {
    isPassword = !isPassword;
    iconData = isPassword ? Icons.visibility_off : Icons.visibility_outlined;
    emit(LoginChangeObscuredState());
  }
}
