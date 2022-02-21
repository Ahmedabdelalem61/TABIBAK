import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/models/diabetes_data.dart';
import 'package:tabibak/models/heart_data.dart';
import 'package:tabibak/models/kidney_data.dart';
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
  ProfileScreen({required this.profileProvider}) {}
  late KidneyModel? Kidenymodel = profileProvider.kidenyModel;
  late HeartModel? heartmodel = profileProvider.heartModel;
  late DiabetesModel? diabetestmodel = profileProvider.diabetesModel;

  final ProfileProvider profileProvider;
  @override
  Widget build(BuildContext context) {
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
        child: (profileProvider.isLoading)
            ? Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              )
            : SingleChildScrollView(
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
                                  'signed since  ${CacheHelper.getData(key: 'signed_since')}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  width: double.infinity,
                                  height: 45,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontFamily: 'spartman',
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {},
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
                      if (Kidenymodel != null)
                        Row(
                          children: [
                            buildDiseaseIndicator(
                                diseaseName: 'kidney',
                                Probability: Kidenymodel!
                                    .result2, // result 2 comming as string from the api
                                Result: Kidenymodel!.result1),
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 40.0),
                                Row(
                                  children: [
                                    buildTextchips(
                                        entry: 'age', val: Kidenymodel!.age),
                                    buildTextchips(
                                        entry: 'al', val: Kidenymodel!.al),
                                  ],
                                ),
                                Row(
                                  children: [
                                    buildTextchips(
                                        entry: 'su', val: Kidenymodel!.su),
                                    buildTextchips(
                                        entry: 'bgr', val: Kidenymodel!.bgr),
                                  ],
                                ),
                                Row(
                                  children: [
                                    buildTextchips(
                                        entry: 'bu', val: Kidenymodel!.bu),
                                    buildTextchips(
                                        entry: 'sc', val: Kidenymodel!.sc),
                                  ],
                                ),
                                Row(
                                  children: [
                                    buildTextchips(
                                        entry: 'hem', val: Kidenymodel!.hemo),
                                    buildTextchips(
                                        entry: 'pcv', val: Kidenymodel!.pcv),
                                  ],
                                ),
                                buildTextchips(
                                    entry: 'wc', val: Kidenymodel!.wc),
                              ],
                            ))
                          ],
                        ),
                      if (heartmodel != null)
                        Row(
                          children: [
                            buildDiseaseIndicator(
                                diseaseName: 'heart',
                                Probability: heartmodel!.result2,
                                Result: heartmodel!.result1),
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
                                    buildTextchips(
                                        entry: 'age', val: heartmodel!.age),
                                    buildTextchips(
                                        entry: 'cp', val: heartmodel!.cp),
                                  ],
                                ),
                                Row(
                                  children: [
                                    buildTextchips(
                                        entry: 'tre',
                                        val: heartmodel!.trestbps),
                                    buildTextchips(
                                        entry: 'cho', val: heartmodel!.chol),
                                  ],
                                ),
                                Row(
                                  children: [
                                    buildTextchips(
                                        entry: 'tha', val: heartmodel!.thalach),
                                    buildTextchips(
                                        entry: 'exa', val: heartmodel!.exang),
                                  ],
                                ),
                                Row(
                                  children: [
                                    buildTextchips(
                                        entry: 'peak',
                                        val: heartmodel!.oldpeak),
                                    buildTextchips(
                                        entry: 'ca', val: heartmodel!.ca),
                                  ],
                                ),
                              ],
                            ))
                          ],
                        ),
                      if (diabetestmodel != null)
                        Row(
                          children: [
                            buildDiseaseIndicator(
                                diseaseName: 'diabetes',
                                Probability: diabetestmodel!.result2,
                                Result: diabetestmodel!.result1),
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 40),
                                Row(
                                  children: [
                                    buildTextchips(
                                        entry: 'age', val: diabetestmodel!.age),
                                    buildTextchips(
                                        entry: 'Pre',
                                        val: diabetestmodel!.Pregnancies),
                                  ],
                                ),
                                Row(
                                  children: [
                                    buildTextchips(
                                        entry: 'Glu',
                                        val: diabetestmodel!.Glucose),
                                    buildTextchips(
                                        entry: 'Ins',
                                        val: diabetestmodel!.Insulin),
                                  ],
                                ),
                                buildTextchips(
                                    entry: 'Ski',
                                    val: diabetestmodel!.SkinThickness),
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
