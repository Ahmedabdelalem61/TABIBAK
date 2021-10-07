import 'package:flutter/material.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';

import 'diabetes_result_screen.dart';
import 'heart_result_screen.dart';

class DiabetesFormScreen extends StatefulWidget {
  @override
  DiabetesFormScreenState createState() => DiabetesFormScreenState();
}

class DiabetesFormScreenState extends State<DiabetesFormScreen> {
  int _activeStepIndex = 0;

/*
*       "age": "50.00",
        "Pregnancies": 120,
        "Glucose": 250,
        "SkinThickness": 360,
        "Insulin": 150
* */

  TextEditingController age = TextEditingController();
  TextEditingController Pregnancies = TextEditingController();
  TextEditingController Glucose = TextEditingController();
  TextEditingController SkinThickness = TextEditingController();
  TextEditingController Insulin = TextEditingController();


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
                StepperTextFormField(label:'Pregnancies' ,controller: Pregnancies),
                SizedBox(
                  height: 8,
                ),
                StepperTextFormField(controller: Glucose, label: 'Glucose'),
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
                  StepperTextFormField(controller: SkinThickness, label: 'SkinThickness'),

                  const SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(controller: Insulin, label: 'Insulin'),
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
                BuildTextforstepper(controller: Pregnancies, val: 'Pregnancies'),
                BuildTextforstepper(controller: Glucose, val: 'Glucose'),
                BuildTextforstepper(controller: SkinThickness, val: 'SkinThickness'),
                BuildTextforstepper(controller: Insulin, val: 'Insulin'),

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
            primary: defaultColor!,
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
                navigateTo(context, DaibetesResultScreen());
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
