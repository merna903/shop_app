import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/app_cubit.dart';
import 'package:shop_app/cubits/appstates.dart';
import 'package:shop_app/cubits/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding_screen.dart';
import 'package:shop_app/shared/blocObserver.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/thems.dart';

import 'shared/components/constans.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget startWidget;
  bool? onBoarding = CacheHelper.getDataOnBoarding(key: 'onBoarding');
  token = CacheHelper.getDataOnBoarding(key: 'token').toString();
  print(token);
  if(onBoarding != null)
    {
      if(token != 'null')
        {
          startWidget = const HomeScreen();
        }
      else
        {
          startWidget = LoginScreen();
        }
    }
  else
    {
      startWidget = const OnBoardingScreen();
    }

  runApp( MyApp(isDark: isDark,
    startWidget: startWidget,));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget ;
  const MyApp({super.key, this.isDark,this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(fromShared : isDark)),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getProfileData())
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (BuildContext context, state)
        {
          var mode = AppCubit.get(context).isDark;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThem,
            darkTheme: darkThem,
            // mode ? ThemeMode.dark :
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
        listener: (BuildContext context, Object? state)
        {

        },
      ),
    );
  }
}

