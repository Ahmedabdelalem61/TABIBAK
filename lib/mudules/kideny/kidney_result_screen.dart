import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';

class KidneyResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(IconBroken.Arrow___Left_2),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(CacheHelper.getData(key: 'kideny_result')==0)
              Text('please visit a doctor',style: TextStyle(fontWeight:FontWeight.bold),),
              if(CacheHelper.getData(key: 'kideny_result')==1)
              Text('your medical analysis is negative',style: TextStyle(color: defaultColor,fontWeight:FontWeight.bold),),
              SizedBox(height: 20,),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: CacheHelper.sharedPreferences!.getDouble('kideny_probability')!,
                center: new Text(
                  "${CacheHelper.sharedPreferences!.getDouble('kideny_probability')!*100}%",
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: CacheHelper.getData(key: 'kideny_result')==0?Colors.red:defaultColor,
              ),
            ],
          ),
        ));
  }
}
