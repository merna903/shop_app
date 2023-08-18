
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;
  void postRegisterData({
    required String name,
    required String email,
    required String password,
    required String phone
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        }).then((value) {
          registerModel = RegisterModel.fromJson(value.data);
          emit(RegisterSuccessState(registerModel!));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
    IconData suffix = Icons.visibility_off;
    bool isPassword = true;

    changePasswordVisibility() {
      isPassword = !isPassword;
      suffix = isPassword ? Icons.visibility : Icons.visibility_off;
      emit(RegisterChangePasswordState());
    }
  }