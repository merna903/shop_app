
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel ;
  void userLogin({
    required String email,
    required String password,
})
  {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN,
        data:{
          'email':email,
          'password':password,
        }).then((value){
          print(value.data.toString());
          loginModel = LoginModel.fromJson(value.data);
          emit(LoginSuccessState(loginModel));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_off;
  bool isPassword = true;

  changePasswordVisibility()
  {
    isPassword =! isPassword;
    suffix = isPassword? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordState());
  }
}