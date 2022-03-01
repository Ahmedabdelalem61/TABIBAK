import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/mudules/profile/edit_profile_provider.dart';
import 'package:tabibak/mudules/profile/profile_provider.dart';
import 'package:tabibak/shared/components/component.dart';
import 'package:tabibak/shared/constants/constants.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({required this.profileProvider}){}
  ProfileProvider profileProvider;
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final editProvider =
        Provider.of<EditProfileProfider>(context, listen: true);
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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (editProvider.isProfileImgLoad)
                LinearProgressIndicator(
                  color: defaultColor,
                ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Stack(children: [
                  CircleAvatar(
                    backgroundColor: defaultColor,
                    radius: 55,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: editProvider.profileImage != null
                          ? FileImage(editProvider.profileImage!)
                              as ImageProvider
                          : NetworkImage(
                              CacheHelper.getData(key: 'profile_image')??defaultProfileImg,
                            ),
                    ),
                  ),
                  Positioned(
                    left: 75,
                    top: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade100,
                      ),
                      child: IconButton(
                        onPressed: () {
                          editProvider
                              .getProfileImage(context)
                              .then((value) {});
                        },
                        icon: Icon(
                          Icons.camera_alt_sharp,
                          color: defaultColor,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultTextFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "phone must not be empty";
                      }
                      return null;
                    },
                    label: 'phone number',
                    prefix: Icons.mobile_friendly),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(
                        fontFamily: 'spartman',
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){
                    if (formKey.currentState!.validate()){
                      editProvider.uploadProfileImageAndPhone(context, phoneController.text);//with firebase to pass it to api 
                      }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
