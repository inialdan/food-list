import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/pages/about.dart';
import 'package:food_app/pages/add_food.dart';
import 'package:food_app/pages/detail_food.dart';
import 'package:food_app/pages/edit_food.dart';
import 'package:food_app/pages/home.dart';
import 'package:food_app/pages/login.dart';
import 'package:food_app/pages/profile.dart';
import 'package:food_app/pages/setting.dart';
import 'package:food_app/providers/food_provider.dart';
import 'package:provider/provider.dart';

import 'pages/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FoodProvider(),
      child: Consumer<FoodProvider>(
        builder: (context, setting, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: setting.brigthness,
          ),
          initialRoute: '/',
          routes: {
            '/': (_) => LoginPage(),
            '/register': (_) => RegisterPage(),
            '/home': (_) => HomePage(),
            '/about': (_) => AboutPage(),
            '/add': (_) => AddFoodPage(),
            '/detail': (_) => DetailFood(),
            '/profile': (_) => ProfilePage(),
            '/edit': (_) => EditFoodPage(),
            '/setting': (_) => SettingPage(),
          },
        ),
      ),
    );
  }
}
