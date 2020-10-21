import 'package:flutter/material.dart';

import 'package:flutt_pelis/src/models/pelicula_model.dart';

class MoviesListHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  MoviesListHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    // Tamaño de la pantalla del dispositivo
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      // 20% de la altura de la pantalla del dispositivo
      //  >> Para la pantalla del emulador disponible, el 20%
      //  produce un error de Overflow por lo que se opta por
      //  aplicar un 25%
      //  Y, con el título por cada película, se hace necesario un 0.28
      height: _screenSize.height * 0.20, // con
      child: PageView(
        children: _cards(context),
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        pageSnapping: false,
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
