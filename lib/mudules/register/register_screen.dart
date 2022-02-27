import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/mudules/register/register_provider.dart';
import 'package:tabibak/shared/components/component.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';
import 'package:tabibak/shared/styles/themes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController useranmeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final _registerProvider = Provider.of<RegisterProvider>(context, listen: true);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _registerProvider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 120,
                      height: 120,
                      child: Image(
                          color: defaultColor,
                          image: AssetImage(
                              'assets/logo/TABIBAK-logos_transparent.png'))),
                  Text(
                    _registerProvider.loginType == registerOrLogn.login
                        ? 'Login'
                        : 'Register',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'spartman',
                        color: defaultColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  DefaultTextFormField(
                      controller: useranmeController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "username must not be empty";
                        }
                        return null;
                      },
                      label: 'username',
                      prefix: IconBroken.User),
                  SizedBox(
                    height: 8.0,
                  ),
                  if (_registerProvider.loginType == registerOrLogn.register)
                    DefaultTextFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Email Address must not be empty";
                          }
                          return null;
                        },
                        label: 'Email Address',
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
                    ispassword:
                        _registerProvider.passwordIconVisible ? false : true,
                    suffixPressed: () {
                      _registerProvider.changePasswordVisibility();
                    },
                    prefix: Icons.lock_outline,
                    suffix: _registerProvider.passwordIconVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_registerProvider.isLoading)
                    Center(child: CircularProgressIndicator()),
                  if (!_registerProvider.isLoading)
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Text(
                          _registerProvider.loginType == registerOrLogn.login
                              ? 'login'
                              : 'register',
                          style: TextStyle(
                              fontFamily: 'spartman',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (_registerProvider.formKey.currentState?.validate() as bool)
                            _registerProvider.registerWithEmailAndPassword(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                                username: useranmeController.text);
                                FocusManager.instance.primaryFocus?.unfocus();
                          //
                        },
                      ),
                    ),
                  if(!_registerProvider.isLoading)
                  TextButton(
                    onPressed: () {
                      useranmeController.clear();
                      passwordController.clear();
                      _registerProvider.setFormKeyState(context,_registerProvider);
                      _registerProvider.toggleRegisterLogin();
                    },
                    child: Text(
                        (_registerProvider.loginType == registerOrLogn.login)
                            ? 'create a new account'
                            : 'already have an account?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
