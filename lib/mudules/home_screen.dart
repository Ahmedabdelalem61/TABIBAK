import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/mudules/diabetes/diabetes_form_screen.dart';
import 'package:tabibak/mudules/profile/profile_provider.dart';
import 'package:tabibak/mudules/profile/profile_screen.dart';
import 'package:tabibak/shared/components/component.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/constants/constants.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';
import 'heart/heart_form_screen.dart';
import 'kideny/kidney_form_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        actions: [
          IconButton(
              onPressed: () {
                CacheHelper.saveData(
                    key: 'token',
                    value:
                        '790e890d571753148bbc9c4447f106e74ecf4d1404f080245f3e259703d58b09');
              },
              icon: Icon(Icons.remove)),
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 15),
            child: IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                    ChangeNotifierProvider<ProfileProvider>(
                      create: (_) => ProfileProvider()..getHeartData(context),
                      child: Consumer<ProfileProvider>(
                          builder: (_, profileProvider, childl) {
                        return ProfileScreen (profileProvider: profileProvider,);
                      }),
                    ),
                  );
                },
                icon: Icon(
                  IconBroken.Category,
                  size: 25,
                  color: Colors.white,
                )),
          )
        ],
      ),
      backgroundColor: defaultColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Hi!\n${CacheHelper.getData(key: 'username').toString().split(' ')[0].toUpperCase()}',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
            child: Text(
              'Tabibak is here For You!',
              style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'spartman',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                )),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'categories',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: defaultColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            buildCategory(
                                context: context,
                                ImgURL: heartImgURL,
                                diseasename: 'Heart',
                                navigaTo: HeartFormScreen()),
                            SizedBox(
                              width: 10,
                            ),
                            buildCategory(
                                context: context,
                                navigaTo: KidnyFormScreen(),
                                ImgURL: kidneyImgUrl,
                                diseasename: 'kidney'),
                            SizedBox(
                              width: 10,
                            ),
                            buildCategory(
                                context: context,
                                navigaTo: DiabetesFormScreen(),
                                ImgURL: diabetesImgUrl,
                                diseasename: 'diabetes'),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
