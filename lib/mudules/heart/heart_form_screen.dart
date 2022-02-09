import 'package:flutter/material.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';

import 'heart_result_screen.dart';

class HeartFormScreen extends StatefulWidget {
  @override
  HeartFormScreenState createState() => HeartFormScreenState();
}

class HeartFormScreenState extends State<HeartFormScreen> {
  int _activeStepIndex = 0;

  /*
  *  "age": "50.00",
        "cp": "200.01",
        "trestbps": "350.00",
        "chol": "50.00",
        "thalach": "100.00",
        "exang": "360.00",
        "oldpeak": "140.00",
        "ca": "900.00"
        * */

  TextEditingController age = TextEditingController();
  TextEditingController cp = TextEditingController();
  TextEditingController trestbps = TextEditingController();
  TextEditingController chol = TextEditingController();
  TextEditingController thalach = TextEditingController();
  TextEditingController exang = TextEditingController();
  TextEditingController oldpeak = TextEditingController();
  TextEditingController ca = TextEditingController();

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text(
            'step 1',
            style: TextStyle(color: Colors.blueGrey),
          ),
          content: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                StepperTextFormField(label:'age' ,controller: age),
                SizedBox(
                  height: 8,
                ),
                StepperTextFormField(label:'cp' ,controller: cp),
                SizedBox(
                  height: 8,
                ),
                StepperTextFormField(controller: trestbps, label: 'trestbps'),
                const SizedBox(
                  height: 8,
                ),
                StepperTextFormField(controller: chol, label: 'chol'),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text(
              'step 2',
              style: TextStyle(color: Colors.blueGrey),
            ),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(controller: thalach, label: 'thalach'),
                  const SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(controller: exang, label: 'exang'),
                  SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(controller: oldpeak, label: 'oldpeak'),
                  const SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(controller: ca, label: 'ca'),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text(
              'Confirm',
              style: TextStyle(color: Colors.blueGrey),
            ),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                BuildTextforstepper(controller: age, val: 'age'),
                BuildTextforstepper(controller: cp, val: 'cp'),
                BuildTextforstepper(controller: trestbps, val: 'trestbps'),
                BuildTextforstepper(controller: chol, val: 'chol'),
                BuildTextforstepper(controller: thalach, val: 'thalach'),
                BuildTextforstepper(controller: exang, val: 'exang'),
                BuildTextforstepper(controller: oldpeak, val: 'oldpeak'),
                BuildTextforstepper(controller: ca, val: 'ca'),
              ],
            )))
      ];

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
        body: Theme(
          data: ThemeData(

              colorScheme: ColorScheme.light(
            primary: defaultColor,
          )),
          child: Stepper(
            physics: BouncingScrollPhysics(),
            type: StepperType.vertical,
            currentStep: _activeStepIndex,
            steps: stepList(),
            onStepContinue: () {
              if (_activeStepIndex < (stepList().length - 1)) {
                setState(() {
                  _activeStepIndex += 1;
                });
              } else {
                navigateTo(context, HeartResultScreen());
              }
            },
            onStepCancel: () {
              if (_activeStepIndex == 0) {
                return;
              }

              setState(() {
                _activeStepIndex -= 1;
              });
            },
            onStepTapped: (int index) {
              setState(() {
                _activeStepIndex = index;
              });
            },
          ),
        ));
  }

  Widget StepperTextFormField(
      {
        @required TextEditingController? controller,
        var onSubmit,
        var onChange,
        var onTap,
        bool ispassword = false,
        @required String? label,
        IconData? suffix,
        var suffixPressed}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      obscureText: ispassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        border:  OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            )),
      ),
    );
  }
  Widget BuildTextforstepper({@required String? val,@required TextEditingController? controller})=>
      Text('$val : ${controller!.text},',style: TextStyle(fontFamily: 'spartman',fontWeight: FontWeight.bold),);
}
/*
*
* */
