import 'package:flutter/material.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';


Widget DefaultTextFormField(
    {@required TextEditingController? controller,
    @required TextInputType? type,
    var onSubmit,
    var onChange,
    var onTap,
    bool ispassword = false,
    @required validate,
    @required String? label,
    @required IconData? prefix,
    IconData? suffix,
    var suffixPressed}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: ispassword,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    validator: validate,
    onTap: onTap,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(icon: Icon(suffix), onPressed: suffixPressed)
          : null,
      border: OutlineInputBorder(),
    ),
  );
}

Widget defalutAppBar({
  @required BuildContext? context,
  String text = "",
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(text),
    actions: actions,
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context!);
      },
      icon: Icon(IconBroken.Arrow___Left_2),
    ),
    titleSpacing: 5,
    );
}
