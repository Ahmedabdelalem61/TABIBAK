import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibak/mudules/home_screen.dart';
import 'package:tabibak/mudules/register/register_provider.dart';
import 'package:tabibak/mudules/register/register_screen.dart';
import 'package:tabibak/shared/styles/themes.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  print(CacheHelper.getData(key: 'token'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme!,
      home: SafeArea(
          child: ChangeNotifierProvider<RegisterProvider>(
        create: (_) => RegisterProvider(),
        child: CacheHelper.getData(key: 'token') == null? RegisterScreen():HomeScreen(),
      )),
    );
  }
}
