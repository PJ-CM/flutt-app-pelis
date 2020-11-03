import 'package:flutter/material.dart';

import 'package:flutt_pelis/src/pages/home_page.dart';
import 'package:flutt_pelis/src/pages/movie_detail.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    ////'home'                  : ( BuildContext context ) => HomePage(),
    //otra forma, desde la clase en sí
    HomePage.pageName: (BuildContext context) => HomePage(),

    MovieDetail.pageName: (BuildContext context) => MovieDetail(),
  };
}
