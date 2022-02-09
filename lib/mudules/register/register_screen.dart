
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/mudules/home_screen.dart';
import 'package:tabibak/mudules/register/register_provider.dart';
import 'package:tabibak/shared/components/component.dart';
import 'package:tabibak/shared/components/news_component.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController useranmeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {

  }

  @override
  Widget build(BuildContext context) {
    final _registerProvider = Provider.of<RegisterProvider>(context,listen: true);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 35, fontFamily: 'spartman'),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  DefaultTextFormField(
                      controller: useranmeController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if ( value!.isEmpty) {
                          return "username must not be empty";
                        }
                        return null;
                      },
                      label: 'username',
                      prefix: IconBroken.User),
                  SizedBox(
                    height: 8.0,
                  ),
                  DefaultTextFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Email Adress must not be empty";
                        }
                        return null;
                      },
                      label: 'Email Adress',
                      prefix: Icons.email_outlined),
                  SizedBox(
                    height: 8.0,
                  ),
                  DefaultTextFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "password must not be empty";
                        }
                        return null;
                      },
                      label: 'password',
                      ispassword: true,
                      suffixPressed: (){
                       // SocialLoginCubit.get(context).changePasswordVisibility();
                      },
                      prefix: Icons.lock_outline,
                      suffix:Icons.password_outlined,//SocialLoginCubit.get(context).suuffix ,
                      onSubmit: (val) {
                        // if (formKey.currentState.validate()) {
                        //   SocialLoginCubit.get(context).userLogin(
                        //       email: emaiController.text,
                        //       password: passwordController.text
                        //   );
                        // }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  if(_registerProvider.isLoading)
                    Center(child: CircularProgressIndicator()),
                  if(!_registerProvider.isLoading)
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),

                          ),
                        ),
                      ),
                      child: Text('register',style: TextStyle( fontFamily: 'spartman',fontSize: 15,fontWeight: FontWeight.bold),),
                      onPressed: () {
                        if(_formKey.currentState!.validate())
                        _registerProvider.registerWithEmailAndPassword(context: context,email: emailController.text,password: passwordController.text,username: useranmeController.text);
                       //
                      },
                    ),

                  ),
                  TextButton(onPressed: (){}, child: Text('already have an account?')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
