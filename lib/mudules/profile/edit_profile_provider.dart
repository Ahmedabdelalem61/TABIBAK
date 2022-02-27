import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:tabibak/networking/api_provider.dart';
import 'package:tabibak/shared/components/component.dart';
import 'package:tabibak/shared/components/show_alert_dialog.dart';
import 'package:tabibak/shared/constants/constants.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';

class EditProfileProfider extends ChangeNotifier {
  File? profileImage;
  final picker = ImagePicker();
  late String profilImageURL = defaultProfileImg;
  bool isProfileImgLoad = false;
  Future getProfileImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    isProfileImgLoad = false;
    notifyListeners();
  }

  void uploadProfileImageAndPhone(BuildContext context, String phone) {
    isProfileImgLoad = true;
    notifyListeners();
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'profile_images/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print('the image path is ${value}');
          profilImageURL = value;
          isProfileImgLoad = false;
          notifyListeners();
          CacheHelper.sharedPreferences!.setString('profile_image', value);
          updatePhoneAndImage(context: context, phone: phone);
        }).catchError((error) {
          print(error);
          showAlertDialog(context,
              title: 'failed to upload the image',
              content: error.toString(),
              defaultActionText: 'OK');
        });
      }).catchError((error) {
        showAlertDialog(context,
            title: 'failed to upload the image',
            content: error.toString(),
            defaultActionText: 'OK');
        print(error);
      });
    }
  }

  Future<void> updatePhoneAndImage(
      {required String phone, required BuildContext context}) async {
    await ApiProvider.internal()
        .put('https://tabiba.herokuapp.com/account/api/profile/', body: {
      "phone": phone,
      "photo": CacheHelper.getData(key: 'profile_image') as String
    }, header: {
      'Authorization': 'Token ${CacheHelper.getData(key: 'token')}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((value) {
      if(value['status_code'] == 200){
        CacheHelper.saveData(key: 'phone',value: phone);
      Navigator.of(context).pop();
        print(value.toString());
      }else{
        buildEndedSession(context,);
      }
    });
  }
  
}
