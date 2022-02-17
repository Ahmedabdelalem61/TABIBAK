import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabibak/mudules/home_screen.dart';
import 'package:tabibak/networking/api_provider.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/components/show_exception_alert_dialog.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';
enum registerOrLogn {login,register}
class RegisterProvider extends ChangeNotifier{
  ApiProvider _ApiInstance = ApiProvider();
  bool isLoading  = false;
  bool passwordIconVisible  = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  registerOrLogn loginType = registerOrLogn.login;

  void _setIsLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  void setFormKeyState(BuildContext context,RegisterProvider? registerProvider) {
    formKey = GlobalKey<FormState>();
    notifyListeners();
  }

  Future<void> registerWithEmailAndPassword({required BuildContext context ,required String username,required String email,required String password}) async {
    _setIsLoading();
    if(loginType == registerOrLogn.register){
      final _response = await _ApiInstance.postWithDio(
        "https://tabiba.herokuapp.com/account/api/register/",
        body: {
          "username": username,
          "email": email,
          "password": password,
        }, headers: {
        'Content-Type': 'application/json'
      },
      );
       /* {user: {
          id: 5,
          username: 'hdhdheh',
          email: 'hxxhxhh@gmail.com'
       },
      token: '8e49cad9eaad3fad3798f6510875fc6c4d5e314df0a35fbe343951e576664b8b'
      }*/
      if(_response['status_code'] == 200){
        navigateAndFinish(context, HomeScreen());
        print(_response.toString());
        CacheHelper.saveData(key: 'token', value: _response['response']['token']as String);
        CacheHelper.saveData(key: 'username', value: _response['response']['user']['username']);
        CacheHelper.saveData(key: 'email', value: _response['response']['user']['email']);
      }
      else{
        showExceptionAlertDialog(context, title: 'failed to register', message: _response['response'].toString());
      }
    }else{
      final _response = await _ApiInstance.postWithDio(
        "https://tabiba.herokuapp.com/account/api/login/",
        body: {
          "username": username,
          "password": password,
        }, headers: {
        'Content-Type': 'application/json'
      },
      );
      if(_response['status_code'] == 200)
        navigateAndFinish(context, HomeScreen());
      else{
        showExceptionAlertDialog(context, title: 'failed to login', message: _response['response'].toString());
      }
    }
    _setIsLoading();

    await getProfileData();
  }

  void toggleRegisterLogin(){
    if(loginType == registerOrLogn.login){
      loginType = registerOrLogn.register;
    }else{
      loginType = registerOrLogn.login;
    }
    passwordIconVisible = false;
    notifyListeners();
  }

  void changePasswordVisibility(){
    passwordIconVisible = !passwordIconVisible;
    notifyListeners();
  }


  //TODO: delete this method later
  Future<void> getProfileData() async{
    final _response = await _ApiInstance.getWithDio( 'https://tabiba.herokuapp.com/account/api/profile/',headers: {
    'Authorization':'c0688f39399841938898efaed72c02fe98b6062d20e997b397e69300aaf6776c',
  });
  print(_response);
  } 


}
