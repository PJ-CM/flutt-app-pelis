
import 'package:flutter/material.dart';

////import 'package:flutt_pelis/src/pages/home_page.dart';
import 'package:flutt_pelis/src/routes/routes.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Películas',
      ////initialRoute: '/',
      ////routes: {
      ////  'home': ( BuildContext context ) => HomePage(),
      ////},
      initialRoute: 'home',
      routes: getAppRoutes(),
    );

  }

}
