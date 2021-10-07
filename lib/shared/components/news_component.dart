import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Widget defaultButton({
  @required var whenPress ,
  Color background = Colors.blue,
  @required String? text,
  Color textColor = Colors.white,
  bool fullWidth = true,
  double? width,
  bool upperCase = true,
}) =>
    Container(
      width: fullWidth ? double.infinity : width ?? null,
      child: MaterialButton(
        height: 40.0,
        onPressed: whenPress,
        color: background,
        child: Text(
          upperCase ? text!.toUpperCase() : text!,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );






void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => widget) , (route) => false);

Widget defaultTextButton(
{@required var function,
@required String? text,
}
){
  return TextButton(onPressed: function, child: Text(text!));
}