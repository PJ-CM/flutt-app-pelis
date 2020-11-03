import 'package:flutter/material.dart';

import 'package:flutt_pelis/src/models/pelicula_model.dart';

class MovieDetail extends StatelessWidget {
  static final pageName = 'movieDetail';

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        // child: Text(':: Aloha desde el detalle de la PELI!! ::'),
        child: Text(':: Aloha desde el detalle de "${pelicula.title}"!! ::'),
      ),
    );
  }
}
