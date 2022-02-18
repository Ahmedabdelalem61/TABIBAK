import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/mudules/home_screen.dart';
import 'package:tabibak/mudules/profile/profile_provider.dart';
import 'package:tabibak/mudules/register/register_provider.dart';
import 'package:tabibak/mudules/register/register_screen.dart';
import 'package:tabibak/shared/components/component.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _accountProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                CacheHelper.sharedPreferences!.clear();
                navigateTo(
                    context,
                    ChangeNotifierProvider<RegisterProvider>(
                      create: (_) => RegisterProvider(),
                      child: CacheHelper.getData(key: 'token') == null
                          ? RegisterScreen()
                          : HomeScreen(),
                    ));
              },
              child: Text(
                'Logout',
                style: TextStyle(color: defaultColor),
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(IconBroken.Arrow___Left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: defaultColor,
                        radius: 55,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://image.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg'),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${CacheHelper.getData(key: 'username').toString().toUpperCase()}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'spartman',
                                color: defaultColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'TODOlater',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              fontFamily: 'spartman',
                              color: defaultColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Divider(),
                ),
                Text(
                  'personnel Contacts',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: defaultColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .90,
                    child: Card(
                      color: Colors.white.withOpacity(.9),
                      elevation: 9,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.alternate_email,
                                  size: 20,
                                  color: Colors.blueGrey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${CacheHelper.getData(key: 'email')}',
                                  style: TextStyle(
                                      fontFamily: 'spartman',
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  size: 20,
                                  color: Colors.blueGrey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${CacheHelper.getData(key: 'phone') ?? 'haven\'t updated yet'}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'spartman',
                                    color: Colors.blueGrey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Edit your personnel information',
                            style: TextStyle(
                                fontFamily: 'spartman',
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconBroken.Edit_Square,
                              color: defaultColor,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Divider(),
                ),
                Text(
                  'Medical State',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: defaultColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'here is your medical analysis distribution\nand your test result of Disease ',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'spartman',
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                //to add info about disease
                if(CacheHelper.getData(key: 'kideny_result')!=null)
                Row(
                  children: [
                    buildDiseaseIndicator(
                        diseaseName: 'kidney',
                        keyOfProbability: 'kideny_probability',
                        keyOfResult: 'kideny_result'),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 40.0),
                        Row(
                          children: [
                            buildTextchips(entry: 'age', val: 'age'),
                            buildTextchips(entry: 'al', val: 'al'),
                          ],
                        ),
                        Row(
                          children: [
                            buildTextchips(entry: 'su', val: 'su'),
                            buildTextchips(entry: 'bgr', val: 'bgr'),
                          ],
                        ),
                        Row(
                          children: [
                            buildTextchips(entry: 'bu', val: 'bu'),
                            buildTextchips(entry: 'sc', val: 'sc'),
                          ],
                        ),
                        Row(
                          children: [
                            buildTextchips(entry: 'hemo', val: 'hemo'),
                            buildTextchips(entry: 'pcv', val: 'pcv'),
                          ],
                        ),
                        buildTextchips(entry: 'wc', val: 'wc'),
                      ],
                    ))
                  ],
                ),
                if(CacheHelper.getData(key: 'heart_result')!=null)
                Row(
                  children: [
                    buildDiseaseIndicator(
                        diseaseName: 'heart',
                        keyOfProbability: 'heart_probability',
                        keyOfResult: 'heart_result'),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          children: [
                            buildTextchips(entry: 'age', val: '11'),
                            buildTextchips(entry: 'cp', val: '11'),
                          ],
                        ),
                        Row(
                          children: [
                            buildTextchips(entry: 'trestbps', val: '11'),
                            buildTextchips(entry: 'chol', val: '11'),
                          ],
                        ),
                        Row(
                          children: [
                            buildTextchips(entry: 'thalach', val: '11'),
                            buildTextchips(entry: 'exang', val: '11'),
                          ],
                        ),
                        Row(
                          children: [
                            buildTextchips(entry: 'oldpeak', val: '11'),
                            buildTextchips(entry: 'ca', val: '11'),
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
                if(CacheHelper.getData(key: 'diabetes_result')!=null)
                Row(
                  children: [
                    buildDiseaseIndicator(
                        diseaseName: 'diabetes',
                        keyOfProbability: 'diabetes_probability',
                        keyOfResult: 'diabetes_result'),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Row(
                          children: [
                            buildTextchips(entry: 'age', val: '11'),
                            buildTextchips(entry: 'Pregnancy', val: '11'),
                          ],
                        ),
                        Row(
                          children: [
                            buildTextchips(entry: 'Glucose', val: '11'),
                            buildTextchips(entry: 'Insulin', val: '11'),
                          ],
                        ),
                        buildTextchips(entry: 'SkinThickness', val: '45'),
                      ],
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
