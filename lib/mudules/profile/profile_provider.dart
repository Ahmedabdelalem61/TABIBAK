import 'package:flutter/foundation.dart';
import 'package:tabibak/networking/api_provider.dart';
class ProfileProvider extends ChangeNotifier{
  ApiProvider _apiProvider = ApiProvider();

  //waiting the token from the api developer to update the query
  Future<void> getProfileData() async{
    final _response = await _apiProvider.getWithDio( 'https://tabiba.herokuapp.com/account/api/profile/');
    print(_response);
}
}