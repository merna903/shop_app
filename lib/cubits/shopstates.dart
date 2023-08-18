import 'package:shop_app/models/login_model.dart';

import '../models/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates
{
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates
{
  final String error;
  ShopErrorCategoriesDataState(this.error);
}

class ShopFavoritesDataState extends ShopStates{}

class ShopSuccessFavoritesDataState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessFavoritesDataState(this.model);
}

class ShopErrorFavoritesDataState extends ShopStates
{
  final String error;
  ShopErrorFavoritesDataState(this.error);
}

class ShopSuccessGetFavoritesDataState extends ShopStates{}

class ShopErrorGetFavoritesDataState extends ShopStates
{
  final String error;
  ShopErrorGetFavoritesDataState(this.error);
}

class ShopSuccessGetUserDataState extends ShopStates
{
  final LoginModel model;

  ShopSuccessGetUserDataState(this.model);

}

class ShopErrorGetUserDataState extends ShopStates
{
  final String error;
  ShopErrorGetUserDataState(this.error);
}

class ShopEnableUpdateState extends ShopStates {}

class ShopSuccessUpdateDataState extends ShopStates {

  final LoginModel model;

  ShopSuccessUpdateDataState(this.model);

}

class ShopErrorUpdateDataState extends ShopStates
{
  final String error;
  ShopErrorUpdateDataState(this.error);
}

