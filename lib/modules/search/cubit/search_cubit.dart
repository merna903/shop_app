import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_state.dart';
import 'package:shop_app/shared/network/end_points.dart';

import '../../../shared/components/constans.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit(): super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void searchData(String text){
    searchModel = null;
    emit(LoadingSearchState());
    DioHelper.postData(
      url: SEARCH,
      data:
      {
        'text': text,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchState());
    }).catchError((error){
      emit(ErrorSearchState(error.toString()));
    });
  }
}