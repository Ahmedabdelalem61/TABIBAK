import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/mudules/diabetes/diabetes_form_screen.dart';
import 'package:tabibak/mudules/profile/profile_provider.dart';

import 'package:tabibak/mudules/profile/profile_screen.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';

import 'heart/heart_form_screen.dart';
import 'kideny/kidney_form_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Welcome\nDenis H!',
                  style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 15),
                child: IconButton(
                    onPressed: () {
                      navigateTo(
                        context,
                        ChangeNotifierProvider<ProfileProvider>(
                          create: (_) => ProfileProvider()..getProfileData(),
                          child: ProfileScreen(),
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
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Tabibak is here For You!',
              style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Colors.white, fontSize: 15, fontFamily: 'spartman'),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height: 550,
                decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(50),
                    ),
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
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)
                                      // ,color: defaultColor
                                      ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomStart,
                                    clipBehavior: Clip.antiAlias,
                                    children: [
                                      Card(
                                        child: Image(
                                          image: NetworkImage(
                                              'https://image.freepik.com/free-vector/green-heart-with-cardiograph-element_53876-116868.jpg'),
                                          fit: BoxFit.fill,
                                          height: 150,
                                          width: 150,
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'Heart Disease',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'spartman',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  navigateTo(context, HeartFormScreen());
                                },
                                splashColor: defaultColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)
                                      // ,color: defaultColor
                                      ),
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    clipBehavior: Clip.antiAlias,
                                    children: [
                                      Card(
                                        child: Image(
                                          image: NetworkImage(
                                              'https://image.freepik.com/free-photo/cholesterol-diet-healthy-food-nutritional-eating-cardiovascular-disease-reduction-concept-with-fresh-vegetables-paper-kidneys-blue-background-conceptual-composition-with-copyspace_155003-34642.jpg'),
                                          fit: BoxFit.fill,
                                          height: 150,
                                          width: 150,
                                          // color: Colors.white.withOpacity(.5),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'kidney Disease',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'spartman',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  navigateTo(context, KidnyFormScreen());
                                },
                                splashColor: defaultColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)
                                      // ,color: defaultColor
                                      ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomStart,
                                    clipBehavior: Clip.antiAlias,
                                    children: [
                                      Card(
                                        child: Image(
                                          image: NetworkImage(
                                              'https://www.worldkidneyday.org/wp-content/uploads/2015/11/diabetes.jpg'),
                                          fit: BoxFit.fill,
                                          height: 150,
                                          width: 150,
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'Diabetes Disease',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'spartman',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  navigateTo(context, DiabetesFormScreen());
                                },
                                splashColor: defaultColor,
                              ),
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
            ),
          )
        ],
      ),
    );
  }
}
