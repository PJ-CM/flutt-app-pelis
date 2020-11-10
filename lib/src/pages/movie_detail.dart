import 'package:flutter/material.dart';

import 'package:flutt_pelis/src/providers/peliculas_provider.dart';
import 'package:flutt_pelis/src/models/pelicula_model.dart';
import 'package:flutt_pelis/src/models/actores_model.dart';

class MovieDetail extends StatelessWidget {
  static final pageName = 'movieDetail';

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    // Tamaño de la pantalla del dispositivo
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position != null) {
        if (_pageController.position.pixels ==
            _pageController.position.maxScrollExtent) {
          _pageController.position.animateTo(
            _pageController.position.maxScrollExtent - _screenSize.width * 0.35,
            duration: Duration(milliseconds: 1000),
            curve: Curves.elasticOut,
          );
        }
        if (_pageController.position.pixels ==
            _pageController.position.minScrollExtent) {
          _pageController.position.animateTo(
            _screenSize.width * 0.3,
            duration: Duration(milliseconds: 1000),
            curve: Curves.elasticOut,
          );
        }
      }
    });

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      // body: Center(
      //   // child: Text(':: Aloha desde el detalle de la PELI!! ::'),
      //   child: Text(':: Aloha desde el detalle de "${pelicula.title}"!! ::'),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              _posterTitle(context, pelicula),
              _description(context, pelicula),
              _createCasting(context, pelicula),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          //Para cuando el texto es demasiado largo...
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(pelicula.getBackgroundImg()),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _description(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sipnosis:',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            pelicula.overview,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );

    // **************************************
    // Otra FORMA de alineamiento y/o padding
    // **************************************

    // return Container(
    //   padding: EdgeInsets.symmetric(horizontal: 20.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       SizedBox(
    //         height: 15.0,
    //       ),
    //       Text(
    //         'Sipnosis:',
    //         style: Theme.of(context).textTheme.subtitle2,
    //       ),
    //       SizedBox(
    //         height: 5.0,
    //       ),
    //       Text(
    //         pelicula.overview,
    //         textAlign: TextAlign.justify,
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _createCasting(BuildContext context, Pelicula pelicula) {
    final peliculasProvider = new PeliculasProvider();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Reparto:',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          FutureBuilder(
            future: peliculasProvider.getCast(pelicula.id.toString()),
            // Este initialData se sustituirá por una imagen de precarga
            // initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return _createActoresPageView(snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _createActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorCard(actores[i]),
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getFoto()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
