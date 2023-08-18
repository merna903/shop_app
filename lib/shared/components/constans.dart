import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void signOut (context){
  CacheHelper.clear(key: 'token').then((value) {
    if(value) navigateAndFinish(context, LoginScreen());
  });
}

void printFullText (String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

String token = ' ';