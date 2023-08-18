import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String text,
  required IconData prefix,
  required BuildContext context,
  IconData? suffix,
  bool isPassword = false,
  Function? function ,
  Function? onSubmit ,
  bool isClickable = false,
}) => TextFormField(
  controller: controller,

  style: Theme.of(context).textTheme.bodyMedium,
  keyboardType: type,
  obscureText: isPassword ,
  validator:(s)
  {
    validate(s);
    return null;
  },
  readOnly: isClickable,
  onFieldSubmitted:(String d)
  {
    onSubmit!(d);
  },
  decoration: InputDecoration(
    labelText: text,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).focusColor,
        ),
    ),
    labelStyle: Theme.of(context).textTheme.bodyMedium,
    prefixIcon: Icon(
      prefix,
      color: Theme.of(context).focusColor,
    ),
    suffixIcon: suffix != null ? IconButton(
      icon: Icon(suffix),
      onPressed:()
      {
        function!();
      } ,
    ) :null,
    border: const OutlineInputBorder(),
  ),
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 8.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: primaryColor
      ),
      child: MaterialButton(
        onPressed:() {
          function();
          },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void showToast({
  required String msg,
  required ToastStates state,
}) => Fluttertoast.showToast(
msg: msg,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: ChooseToastColor(state) ,
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WORNING}

Color ChooseToastColor(ToastStates state)
{
  switch(state)
  {

    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.ERROR:
      return Colors.red;
    case ToastStates.WORNING:
      return Colors.amber;
  }
}

void navigateTo(context,widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget ,
  ),
);

void navigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
    builder: (context) => widget ,
  ),
      (Route<dynamic> route) => false,
);