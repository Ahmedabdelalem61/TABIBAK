import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/networking/api_provider.dart';
import 'package:tabibak/shared/components/component.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';

import 'heart_result_screen.dart';

class HeartFormScreen extends StatefulWidget {
  @override
  HeartFormScreenState createState() => HeartFormScreenState();
}

class HeartFormScreenState extends State<HeartFormScreen> {
  int _activeStepIndex = 0;
  GlobalKey<FormState> _formKeySteper1 = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeySteper2 = GlobalKey<FormState>();

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
            child: Form(
              key: _formKeySteper1,
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(label: 'age', controller: age,validatorText: 'age'),
                  SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(label: 'cp', controller: cp,validatorText: 'cp'),
                  SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(controller: trestbps, label: 'trestbps',validatorText: 'trestbps'),
                  const SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(controller: chol, label: 'chol',validatorText: 'chol'),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
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
              child: Form(
                key: _formKeySteper2,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    StepperTextFormField(controller: thalach, label: 'thalach',validatorText: 'thalach'),
                    const SizedBox(
                      height: 8,
                    ),
                    StepperTextFormField(controller: exang, label: 'exang',validatorText: 'exang'),
                    SizedBox(
                      height: 8,
                    ),
                    StepperTextFormField(controller: oldpeak, label: 'oldpeak',validatorText: 'oldpeak'),
                    const SizedBox(
                      height: 8,
                    ),
                    StepperTextFormField(controller: ca, label: 'ca',validatorText:  'ca'),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
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
                Row(
                  children: [
                    BuildTextforstepper(controller: age, val: 'age'),
                    BuildTextforstepper(controller: cp, val: 'cp'),
                    BuildTextforstepper(controller: trestbps, val: 'trestbps'),
                  ],
                ),
                Row(
                  children: [
                    BuildTextforstepper(controller: chol, val: 'chol'),
                    BuildTextforstepper(controller: thalach, val: 'thalach'),
                    BuildTextforstepper(controller: exang, val: 'exang'),
                  ],
                ),
                Row(
                  children: [
                    BuildTextforstepper(controller: oldpeak, val: 'oldpeak'),
                    BuildTextforstepper(controller: ca, val: 'ca'),
                  ],
                ),
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
              if (_activeStepIndex < (stepList().length - 1)){
                if(_formKeySteper1.currentState!.validate() && _activeStepIndex == 0)
                setState(() {
                  _activeStepIndex += 1;
                });
              else if(_activeStepIndex == 1 && _formKeySteper2.currentState!.validate()){
                  setState(() {
                  _activeStepIndex += 1;
                });
              }
              }
              else {
                ApiProvider apiprovider = ApiProvider();
                apiprovider.postWithDio(
                    'https://tabiba.herokuapp.com/heart/api/heart_data',
                    headers: {
                      'Authorization':
                          'Token ${CacheHelper.getData(key: 'token')}'
                    },
                    body: {
                      "age": age.text,
                      "cp": cp.text,
                      "trestbps": trestbps.text,
                      "chol": chol.text,
                      "thalach": thalach.text,
                      "exang": "360.00",
                      "oldpeak": "140.00",
                      "ca": "900.00"
                    }).then((value) {
                  print(value.toString());
                  CacheHelper.saveData(
                      key: 'heart_result',
                      value: value['response']['result'][0]);
                  CacheHelper.saveData(
                      key: 'heart_probability',
                      value: value['response']['result2'][0][0]);
                  navigateTo(context, HeartrResultScreen());
                });
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
}
/*
*
* */
