import '../../../models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);
}

class RegisterLoadingState extends RegisterStates {}

class RegisterChangeObscuredState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}
