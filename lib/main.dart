import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectbebanpikiran/helper/shared_preference.dart';
import 'package:projectbebanpikiran/model/data_model.dart';
import 'package:projectbebanpikiran/LoginRegisterPage/login_page.dart';
import 'package:projectbebanpikiran/view/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initiateLocalDB();
  SharedPreference().getLoginStatus().then((status) {
    runApp(MaterialApp(
      title: 'Drinktale',
      home: status ? HomePage() : LoginPage(),
      debugShowCheckedModeBanner: false,
    ));
  });
  // runApp(const MyApp());
}

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DataModelAdapter());
  await Hive.openBox<DataModel>("data");
}
