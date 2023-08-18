import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/shopstates.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constans.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../models/change_favorites_model.dart';
import '../models/login_model.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex =0;

  List<Widget> screens =
  [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int , bool> favorites = {};

  HomeModel? homeModel;
  void getHomeData() async
  {
    homeModel = null;
    emit(ShopLoadingHomeDataState());
    await DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id : element.infavorites
        });
      }
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData()
  {
    categoriesModel = null;
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error){
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int id){
    changeFavoritesModel = null;
    favorites[id] = !favorites[id]! ;
    emit(ShopFavoritesDataState());
    DioHelper.postData(
      url: FAVORITES,
      data:
      {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status) {
        favorites[id] = !favorites[id]! ;
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessFavoritesDataState(changeFavoritesModel!));
    }).catchError((error){
      favorites[id] = !favorites[id]! ;
      emit(ShopErrorFavoritesDataState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData()
  {
    favoritesModel = null;
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error){
      emit(ShopErrorGetFavoritesDataState(error.toString()));
    });
  }

  LoginModel? userModel;
  void getProfileData()
  {
    userModel = null;
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error){
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }

  bool isReadOnly = true;
  void enableUpdateProfile() {
    isReadOnly = false;
    emit(ShopEnableUpdateState());
  }

  void updateDataProfile({
    required String name,
    required String email,
    required String phone,
})
  {
    isReadOnly = true;
    DioHelper.putData(
      url: UPDATE,
      data: {
        'name':name,
        'email':email,
        'phone':phone
      },
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateDataState(userModel!));
    }).catchError((error){
      emit(ShopErrorUpdateDataState(error.toString()));
    });
  }
}