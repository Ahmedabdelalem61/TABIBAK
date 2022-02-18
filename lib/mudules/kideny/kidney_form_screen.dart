// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabibak/models/kidney_data.dart';
import 'package:tabibak/networking/api_provider.dart';
import 'package:tabibak/remote/dio_helper.dart';
import 'package:tabibak/shared/components/component.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';

import 'kidney_result_screen.dart';

class KidnyFormScreen extends StatefulWidget {
  @override
  KidnyFormScreenState createState() => KidnyFormScreenState();
}

class KidnyFormScreenState extends State<KidnyFormScreen> {
  int _activeStepIndex = 0;

  TextEditingController age = TextEditingController();
  TextEditingController al = TextEditingController();
  TextEditingController su = TextEditingController();
  TextEditingController bgr = TextEditingController();
  TextEditingController bu = TextEditingController();
  TextEditingController sc = TextEditingController();
  TextEditingController hemo = TextEditingController();
  TextEditingController pcv = TextEditingController();
  TextEditingController wc = TextEditingController();
  bool htn = false;
  GlobalKey<FormState> _formKeySteper1 = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeySteper2 = GlobalKey<FormState>();

  late KidneyModel kidneyModel = KidneyModel(
      age: double.parse(age.text),
      al: double.parse(al.text),
      su: double.parse(su.text),
      bgr: double.parse(bgr.text),
      bu: double.parse(bu.text),
      sc: double.parse(sc.text),
      hemo: double.parse(hemo.text),
      pcv: double.parse(pcv.text),
      wc: double.parse(wc.text),
      htn: htn ? "yes" : "no");

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
                  StepperTextFormField(
                      label: 'age', controller: age, validatorText: 'age'),
                  SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(
                      label: 'al', controller: al, validatorText: 'al'),
                  SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(
                      controller: su, label: 'su', validatorText: 'su'),
                  const SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(
                      controller: bgr, label: 'bgr', validatorText: 'bgr'),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    StepperTextFormField(
                        controller: bu, label: 'bu', validatorText: 'bu'),
                    const SizedBox(
                      height: 8,
                    ),
                    StepperTextFormField(
                        controller: sc, label: 'sc', validatorText: 'sc'),
                    SizedBox(
                      height: 8,
                    ),
                    StepperTextFormField(
                        controller: hemo, label: 'hemo', validatorText: 'hemo'),
                    const SizedBox(
                      height: 8,
                    ),
                    StepperTextFormField(
                        controller: pcv, label: 'pcv', validatorText: 'pcv'),
                    SizedBox(
                      height: 8,
                    ),
                    StepperTextFormField(
                        controller: wc, label: 'wc', validatorText: 'wc'),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('htn',
                              style: TextStyle(
                                  fontFamily: 'spartman',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.blueGrey)),
                          SizedBox(
                            width: 10,
                          ),
                          Switch(
                            value: htn,
                            onChanged: (value) {
                              setState(() {
                                htn = value;
                                print(htn);
                              });
                            },
                            activeTrackColor: defaultColor.withOpacity(.2),
                            activeColor: defaultColor,
                          ),
                        ],
                      ),
                    )
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
                    BuildTextforstepper(controller: al, val: 'al'),
                    BuildTextforstepper(controller: su, val: 'su'),
                  ],
                ),
                Row(
                  children: [
                    BuildTextforstepper(controller: bgr, val: 'bgr'),
                    BuildTextforstepper(controller: bu, val: 'bu'),
                    BuildTextforstepper(controller: sc, val: 'sc'),
                  ],
                ),
                Row(
                  children: [
                    BuildTextforstepper(controller: hemo, val: 'hemo'),
                    BuildTextforstepper(controller: pcv, val: 'pcv'),
                    BuildTextforstepper(controller: wc, val: 'wc'),
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
                ApiProvider apiProvider = ApiProvider();
                apiProvider.postWithDio(
                    'https://tabiba.herokuapp.com/kidney/api/kidney_data',
                    headers: {
                      'Authorization':
                          'Token ${CacheHelper.getData(key: 'token')}'
                    },
                    body: {
                      "age": age.text,
                      "al": al.text,
                      "su": su.text,
                      "bgr": bgr.text,
                      "bu": bu.text,
                      "sc": sc.text,
                      "hemo": hemo.text,
                      "pcv": pcv.text,
                      "wc": wc.text,
                      "htn": htn == true ? 'yes' : 'no'
                    }).then((value) {
                  print('kideny' + value.toString());
                  CacheHelper.saveData(
                      key: 'kideny_result',
                      value: value['response']['result'][0]);
                  CacheHelper.saveData(
                      key: 'kideny_probability',
                      value: value['response']['result2'][0][0]);
                  navigateTo(context, KidneyResultScreen());
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
