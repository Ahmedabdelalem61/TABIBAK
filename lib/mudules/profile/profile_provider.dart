import 'package:flutter/material.dart';
import 'package:tabibak/models/diabetes_data.dart';
import 'package:tabibak/models/heart_data.dart';
import 'package:tabibak/models/kidney_data.dart';
import 'package:tabibak/networking/api_provider.dart';
import 'package:tabibak/shared/components/component.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  KidneyModel? kidenyModel;
  HeartModel? heartModel;
DiabetesModel? diabetesModel;  

  Future<void> getKidenyData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final _response = await ApiProvider.internal().getWithDio(
        'https://tabiba.herokuapp.com/kidney/api/kidney_data',
        headers: {
          'Authorization': 'Token ${CacheHelper.getData(key: 'token')}',
        }).then((value) {
      if (value['status_code'] == 200) {
        if (value['response'].length != 0) {
          kidenyModel = KidneyModel.fromJson(value['response'][value['response'].length-1]);
        }
        isLoading = false;
        notifyListeners();
      } else {
        buildEndedSession(context);
        isLoading = true;
        notifyListeners();
      }
      print('get Kideny data ' + value.toString());
    });
  }


  Future<void> getHeartData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final _response = await ApiProvider.internal().getWithDio(
        'https://tabiba.herokuapp.com/heart/api/heart_data',
        headers: {
          'Authorization': 'Token ${CacheHelper.getData(key: 'token')}',
        }).then((value) {
      if (value['status_code'] == 200) {
        if (value['response'].length != 0) {
          heartModel = HeartModel.fromJson(value['response'][value['response'].length-1]);
        }
        isLoading = false;
        notifyListeners();
      } else {
        buildEndedSession(context);
        isLoading = true;
        notifyListeners();
      }
      print('get heart data ' + value.toString());
    });
  }

   Future<void> getDiabetestData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final _response = await ApiProvider.internal().getWithDio(
        'https://tabiba.herokuapp.com/Diabetes/api/Diabetes_data',
        headers: {
          'Authorization': 'Token ${CacheHelper.getData(key: 'token')}',
        }).then((value) {
      if (value['status_code'] == 200) {
        if (value['response'].length != 0) {
          diabetesModel = DiabetesModel.fromJson(value['response'][value['response'].length-1]);
        }
        isLoading = false;
        notifyListeners();
      } else {
        buildEndedSession(context);
        isLoading = true;
        notifyListeners();
      }
      print('get diabetes data ' + value.toString());
    });
  }
}
