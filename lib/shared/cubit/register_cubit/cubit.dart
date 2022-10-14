import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/models/login_model.dart';
import 'package:salla_app/shared/cubit/register_cubit/states.dart';
import 'package:salla_app/shared/network/end_points.dart';
import 'package:salla_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData iconData = Icons.visibility_off_outlined;
  LoginModel? _loginModel;
// post register data
  void registerData({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String image,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'image': image,
      },
    ).then((value) {
      _loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(_loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

// obscured text method ...
  void changeObscured() {
    isPassword = !isPassword;
    iconData = isPassword ? Icons.visibility_off : Icons.visibility_outlined;
    emit(RegisterChangeObscuredState());
  }
}
