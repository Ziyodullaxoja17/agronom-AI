import 'package:agronom_ai/controller/agro_controller.dart';
import 'package:agronom_ai/data/repository/agro_services_repo.dart';
import 'package:agronom_ai/presentation/screens/login_agro_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => AgroController(agroServicesRepo: AgroServicesRepo()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginAgroScreen(),
      ),
    );
  }
}
