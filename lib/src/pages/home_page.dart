import 'package:flutter/material.dart';

////import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutt_pelis/src/widgets/card_swiper_widget.dart';
import 'package:flutt_pelis/src/providers/peliculas_provider.dart';

class HomePage extends StatelessWidget {
  //Otra forma de establecer el nombre de la página relativo al listado de rutas
  static final pageName = 'home';
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Home :: Películas en Cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //Llamando al deslizador de tarjetas...
            _cardSwiper(),
          ],
        ),
      ),
    );
  }

  Widget _cardSwiper() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );

    //----------------------------------------------------------------------
    //ANTES [2]
    // peliculasProvider.getEnCines();

    // return CardSwiper(
    //   //movies: null,
    //   movies: [1, 2, 3, 4],
    // );

    //----------------------------------------------------------------------
    //ANTES [1]
    // return CardSwiper(
    //   //movies: null,
    //   movies: [1, 2, 3, 4],
    // );
    //----------------------------------------------------------------------
    //ANTES [0]
    // return Container(
    //   padding: EdgeInsets.only(top: 28.0),
    //   width: double.infinity,//todo el ancho posible
    //   height: 300.0,
    //   child: Swiper(
    //     itemBuilder: (BuildContext context,int index){
    //       return new Image.network(
    //         "http://via.placeholder.com/350x150",
    //         fit: BoxFit.fill,
    //       );
    //     },
    //     itemCount: 3,
    //     ////pagination: new SwiperPagination(),
    //     ////control: new SwiperControl(),
    //     layout: SwiperLayout.STACK,
    //     itemWidth: 200.0,
    //   ),
    // );
  }
}
