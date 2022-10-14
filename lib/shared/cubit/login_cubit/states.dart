import 'package:salla_app/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginLoadingState extends LoginStates {}

class LoginChangeObscuredState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}
