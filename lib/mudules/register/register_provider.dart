import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabibak/mudules/home_screen.dart';
import 'package:tabibak/networking/api_provider.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/components/show_exception_alert_dialog.dart';
import 'package:tabibak/shared/constants/constants.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

enum registerOrLogn { login, register }

class RegisterProvider extends ChangeNotifier {
  ApiProvider _ApiInstance = ApiProvider();
  bool isLoading = false;
  bool passwordIconVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  registerOrLogn loginType = registerOrLogn.login;

  void _setIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void setFormKeyState(
      BuildContext context, RegisterProvider? registerProvider) {
    formKey = GlobalKey<FormState>();
    notifyListeners();
  }

  Future<void> registerWithEmailAndPassword(
      {required BuildContext context,
      required String username,
      required String email,
      required String password}) async {
    CacheHelper.sharedPreferences!.clear;
    _setIsLoading();
    if (loginType == registerOrLogn.register) {
      final _response = await _ApiInstance.postWithDio(
        "https://tabiba.herokuapp.com/account/api/register/",
        body: {
          "username": username,
          "email": email,
          "password": password,
        },
        headers: {'Content-Type': 'application/json'},
      );
      if (_response['status_code'] == 200) {
        navigateAndFinish(context, HomeScreen());
        print(_response.toString());
        CacheHelper.saveData(
            key: 'token', value: _response['response']['token'] as String);
        CacheHelper.saveData(
            key: 'username', value: _response['response']['user']['username']);
        CacheHelper.saveData(
            key: 'email', value: _response['response']['user']['email']);
      } else {
        String message = '';
        if (_response['response']['email'] != null &&
            _response['response']['username'] != null)
          message = '${_response['response']['email'][0]}\n'
              '${_response['response']['username'][0]}';
        else if (_response['response']['email'] != null)
          message = '${_response['response']['email'][0]}';
        else {
          message = '${_response['response']['username'][0]}';
        }
        showExceptionAlertDialog(context,
            title: 'failed to register', message: message);
      }
      //else Login
    } else {
      final _response = await _ApiInstance.postWithDio(
        "https://tabiba.herokuapp.com/account/api/login/",
        body: {
          "username": username,
          "password": password,
        },
        headers: {'Content-Type': 'application/json'},
      );
      print('response after login ' + _response.toString());
      if (_response['status_code'] == 200) {
        CacheHelper.saveData(
            key: 'token', value: _response['response']['token']);
        await getProfileData().then((response) {
          print('get profile' + response.toString());
          CacheHelper.saveData(
              key: 'username', value: response['response']['username']);
          CacheHelper.saveData(
              key: 'email', value: response['response']['email']);
          CacheHelper.saveData(key: 'phone', value: response['response']['phone']);
          if(response['response']['photo']!=null){
            print('the image profile from api .....................................'+response['response']['photo'].toString());
            CacheHelper.saveData(key: 'profile_image', value: response['response']['photo']);
          }else{
            CacheHelper.sharedPreferences!.setString('profile_image', defaultProfileImg);
          }
          navigateAndFinish(context, HomeScreen());
        });
      } else {
        showExceptionAlertDialog(context,
            title: 'failed to login',
            message:
                '${_response['response']['non_field_errors'][0].toString()}\nemail or password wrong');
      }
    }

    _setIsLoading();
    CacheHelper.saveData(
        key: 'signed_since',
        value: DateFormat('dd-MM-yyyy').format(DateTime.now()).toString());
    
  }

  void toggleRegisterLogin() {
    if (loginType == registerOrLogn.login) {
      loginType = registerOrLogn.register;
    } else {
      loginType = registerOrLogn.login;
    }
    passwordIconVisible = false;
    notifyListeners();
  }

  void changePasswordVisibility() {
    passwordIconVisible = !passwordIconVisible;
    notifyListeners();
  }

  Future<dynamic> getProfileData() async {
    final _response = await _ApiInstance.getWithDio(
        'https://tabiba.herokuapp.com/account/api/profile/',
        headers: {
          'Authorization': 'Token ${CacheHelper.getData(key: 'token')}',
        });
    return _response;
  }

  
}
