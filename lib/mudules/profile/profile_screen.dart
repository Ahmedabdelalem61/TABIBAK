import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/mudules/profile/profile_provider.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _accountProvider = Provider.of<ProfileProvider>(context);
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
                            'Ahmed Abdelalem',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'spartman',
                                color: defaultColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('any data that will come ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontFamily: 'spartman')),
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
                    height: 180,
                    width: MediaQuery.of(context).size.width * .90,
                    child: Card(
                      color: Colors.white.withOpacity(.9),
                      elevation: 9,
                      child: Column(
                        children: [
                          SizedBox(height: 8.0,),
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
                                  'Ahmed.abdelam61@gmail.com',
                                  style: TextStyle(
                                    fontFamily: 'spartman',
                                    color: Colors.blueGrey,
                                  ),
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
                                  '+2011459031',
                                  style: TextStyle(
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
                            style: TextStyle(fontFamily: 'spartman'),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                IconBroken.Edit_Square,
                                color: defaultColor,
                                size: 25,
                              ))
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
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontFamily: 'spartman')),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Kidney',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: 0.7,
                      center: new Text(
                        "70.0%\n kedney",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * .35,
                            lineHeight: 14.0,
                            percent: 0.5,
                            center: Text(
                              "50.0%",
                              style: new TextStyle(fontSize: 12.0),
                            ),
                            trailing: Text('   albo'),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.purple,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * .35,
                            lineHeight: 14.0,
                            percent: 0.7,
                            center: Text(
                              "50.0%",
                              style: new TextStyle(fontSize: 12.0),
                            ),
                            trailing: Text('  fit'),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.purple,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * .35,
                            lineHeight: 14.0,
                            percent: 0.9,
                            center: Text(
                              "50.0%",
                              style: new TextStyle(fontSize: 12.0),
                            ),
                            trailing: Text(' so'),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.purple,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * .35,
                            lineHeight: 14.0,
                            percent: 1,
                            center: Text(
                              "50.0%",
                              style: new TextStyle(fontSize: 12.0),
                            ),
                            trailing: Text('    col'),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
