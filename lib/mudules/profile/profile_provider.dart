import 'package:flutter/foundation.dart';
import 'package:tabibak/networking/api_provider.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';
class ProfileProvider extends ChangeNotifier{
  ApiProvider _apiProvider = ApiProvider();

  //waiting the token from the api developer to update the query
  Future<void> getProfileData() async{
    final _response = await _apiProvider.getWithDio( 'https://tabiba.herokuapp.com/account/api/profile/',headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':'600a2a88050da9e259dbcd2a90c59807f5ed85375f3d3f18f8502ff98e9255f6',
  });
  print(_response);
  }
}