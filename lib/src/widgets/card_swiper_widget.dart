import 'package:flutt_pelis/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  //Colección de elementos a cargar
  // final List<dynamic> movies;
  final List<Pelicula> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    //Arreglando las dimensiones de las tarjetas para adaptarlas a las dimensiones del dispositivo
    //que se emplee.
    //Se usan, para ello, los MediaQueries (que ofrece datos sobre el ancho, alto, orientación,
    //... del dispositivo)
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 28.0),
      ////width: double.infinity,//todo el ancho posible
      ////height: 300.0,
      //---------------------------------------------------------------------------
      //Adaptando, ahora, al ancho de la pantalla según el dispositivo empleado
      ////width: _screenSize.width * 0.7, //solamente, el 70%
      ////height: _screenSize.height * 0.5, //solamente, el 50%
      //---------------------------------------------------------------------------
      //Mejor, se pasan esos valores de medida dentro del Swiper...
      //---------------------------------------------------------------------------
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqueId = '${movies[index].id}-enCines';
          // Otra opción de identificador único...
          // movies[index].uniqueId = UniqueKey().toString();

          return Hero(
            tag: movies[index].uniqueId,
            //Tras Englobar el Image.network dentro del ClipRRect, para poder redondear
            //las esquinas de los bordes de las tarjetas.
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),

              //A modo de prueba...
              ////child: Text('${movies[index]}'),

              // child: Image.network(
              //   "http://via.placeholder.com/350x150",
              //   fit: BoxFit.fill,
              //   //fit: BoxFit.cover,
              // ),

              child: GestureDetector(
                onTap: () {
                  //Este TIEMPO altera la velocidad del Hero Animation
                  timeDilation = 1.5;
                  print(
                      'ID y Tit de la peli: [${movies[index].id}] - ${movies[index].title}');
                  Navigator.pushNamed(context, 'movieDetail',
                      arguments: movies[index]);
                },
                child: FadeInImage(
                  image: NetworkImage(movies[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
        ////pagination: new SwiperPagination(),
        ////control: new SwiperControl(),
        layout: SwiperLayout.STACK,
        ////itemWidth: 200.0,
        itemWidth: _screenSize.width * 0.7, //solamente, el 70%
        itemHeight: _screenSize.height * 0.5, //solamente, el 50%
      ),
    );
  }
}
