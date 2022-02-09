import 'package:flutter/cupertino.dart';
import 'package:tabibak/mudules/home_screen.dart';
import 'package:tabibak/networking/api_provider.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/components/show_exception_alert_dialog.dart';

class RegisterProvider extends ChangeNotifier{
  ApiProvider _ApiInstance = ApiProvider();
  bool isLoading  = false;

  void _setIsLodaing(){
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> registerWithEmailAndPassword({required BuildContext context ,required String username,required String email,required String password}) async {
    _setIsLodaing();
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
    if(_response['status_code'] == 200)
    navigateAndFinish(context, HomeScreen());
    else{
      showExceptionAlertDialog(context, title: 'failed to register', message: _response['response'].toString());
    }
    print(_response);
    _setIsLodaing();
  }
}
