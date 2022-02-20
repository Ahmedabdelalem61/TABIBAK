import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/mudules/register/register_provider.dart';
import 'package:tabibak/mudules/register/register_screen.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/components/show_alert_dialog.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';

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
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red, width: 3.0)),
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
      onPressed: () {
        Navigator.pop(context!);
      },
      icon: Icon(IconBroken.Arrow___Left_2),
    ),
    titleSpacing: 5,
  );
}

Widget BuildTextforstepper(
    {@required String? val, @required TextEditingController? controller}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          color: defaultColor, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          '$val : ${controller!.text}',
          style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontFamily: 'spartman',
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget buildTextchips({required String? val, required String? entry}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      decoration: BoxDecoration(
          color: defaultColor, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          '$entry : $val',
          style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontFamily: 'spartman',
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget StepperTextFormField(
    {@required TextEditingController? controller,
    var onSubmit,
    var onChange,
    var onTap,
    String? validatorText,
    bool ispassword = false,
    @required String? label,
    IconData? suffix,
    var suffixPressed}) {
  return TextFormField(
    validator: (String? value) {
      if (value!.isEmpty) return '$validatorText must not be empty';
      return null;
    },
    keyboardType: TextInputType.number,
    controller: controller,
    obscureText: ispassword,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    onTap: onTap,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      )),
    ),
  );
}

Widget buildDiseaseIndicator(
    {required String diseaseName,
    required String keyOfProbability,
    required String keyOfResult}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 10,
      ),
      Text(
        diseaseName,
        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          CircularPercentIndicator(
            radius: 110.0,
            lineWidth: 13.0,
            animation: true,
            percent:
                CacheHelper.sharedPreferences!.getDouble(keyOfProbability)!,
            center: new Text(
              "${(CacheHelper.sharedPreferences!.getDouble(keyOfProbability)! * 100).toInt()}.0%",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: CacheHelper.getData(key: keyOfResult) == 0
                ? Colors.red
                : defaultColor,
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    ],
  );
}

Future<void> buildEndedSession(BuildContext context) async {
  await showAlertDialog(context,
          title: 'session ended',
          content: 'please register again',
          defaultActionText: 'OK')
      .then((value) {
    if (value == true) {
      navigateAndFinish(
          context,
          ChangeNotifierProvider<RegisterProvider>(
            create: (_) => RegisterProvider(),
            child: RegisterScreen(),
          ));
    } else {
      Navigator.pop(context);
    }
  });
}
