import 'package:flutter/material.dart';
import 'package:tabibak/mudules/diabetes/diabetes_result_screen.dart';
import 'package:tabibak/networking/api_provider.dart';
import 'package:tabibak/shared/components/component.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';

class DiabetesFormScreen extends StatefulWidget {
  @override
  DiabetesFormScreenState createState() => DiabetesFormScreenState();
}

class DiabetesFormScreenState extends State<DiabetesFormScreen> {
  int _activeStepIndex = 0;
  GlobalKey<FormState> _formKeySteper1 = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeySteper2 = GlobalKey<FormState>();

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
                      label: 'Pregnancies',
                      controller: Pregnancies,
                      validatorText: 'pregnancies'),
                  SizedBox(
                    height: 8,
                  ),
                  StepperTextFormField(
                      controller: Glucose,
                      label: 'Glucose',
                      validatorText: 'Glucose'),
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
                    StepperTextFormField(
                        controller: SkinThickness,
                        label: 'SkinThickness',
                        validatorText: 'SkinThickness'),
                    const SizedBox(
                      height: 8,
                    ),
                    StepperTextFormField(
                        controller: Insulin,
                        label: 'Insulin',
                        validatorText: 'Insulin'),
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
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BuildTextforstepper(controller: age, val: 'age'),
                        BuildTextforstepper(
                            controller: Pregnancies, val: 'Pregnancies'),
                      ],
                    ),
                    Row(
                      children: [
                        BuildTextforstepper(
                            controller: Glucose, val: 'Glucose'),
                        BuildTextforstepper(
                            controller: Insulin, val: 'Insulin'),
                      ],
                    ),
                    BuildTextforstepper(
                        controller: SkinThickness, val: 'SkinThickness'),
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
                if (_formKeySteper1.currentState!.validate() &&
                    _activeStepIndex == 0)
                  setState(() {
                    _activeStepIndex += 1;
                  });
                else if (_activeStepIndex == 1 &&
                    _formKeySteper2.currentState!.validate()) {
                  setState(() {
                    _activeStepIndex += 1;
                  });
                }
              } else {
                ApiProvider apiProvider = ApiProvider();
                apiProvider.postWithDio(
                    'https://tabiba.herokuapp.com/Diabetes/api/Diabetes_data',
                    headers: {
                      'Authorization':
                          'Token ${CacheHelper.getData(key: 'token')}'
                    },
                    body: {
                      "age": age.text,
                      "Pregnancies": Pregnancies.text,
                      "Glucose": Glucose.text,
                      "SkinThickness": SkinThickness.text,
                      "Insulin": Insulin.text,
                    }).then((value) {
                  if (value['status_code'] == 200) {
                    CacheHelper.saveData(
                        key: 'diabetes_result',
                        value: value['response']['result'][0]);
                    CacheHelper.saveData(
                        key: 'diabetes_probability',
                        value: value['response']['result2'][0][0]);
                    navigateTo(context, DiabetesResultScreen());
                  } else {
                    buildEndedSession(context);
                  }
                  print(value.toString());
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
