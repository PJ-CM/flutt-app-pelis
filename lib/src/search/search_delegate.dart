import 'package:flutter/material.dart';

import 'package:flutt_pelis/src/providers/peliculas_provider.dart';
import 'package:flutt_pelis/src/models/pelicula_model.dart';

class DataSearch extends SearchDelegate {
  String get searchFieldLabel => 'Buscar...';

  final peliculasProvider = new PeliculasProvider();

  /* REFERIDO A LA PRUEBA TEMPORAL DE SUGERENCIAS */
  /*
  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Superman',
    'Superman II',
    'Superman III',
    'Superman IV',
    'Shazam!',
    'Ironman',
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitán América',
  ];
  */

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implementar las acciones relativas a resetear la caja de búsqueda
    // o cancelar la propia opción de búsqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print('¡¡CLIC para resetear!!');
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implementar la acción de que aparezca un icono a la izquierda del AppBar
    // de búsqueda, ya sea el propio icono de lupa u otro para volver al paso anterior
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress:
            transitionAnimation, // tiempo de animación del icono comprendido entre 0 y 1 (defecto null)
      ),
      onPressed: () {
        print('Leading ICON Press');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implementar la acción que muestra los resultados de la búsqueda
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((peli) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(peli.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain, // Para que no se salga de los bordes
                ),
                title: Text(peli.title),
                subtitle: Text(peli.originalTitle),
                onTap: () {
                  close(context, null);
                  peli.uniqueId = '';
                  Navigator.pushNamed(context, 'movieDetail', arguments: peli);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  /* REFERIDO A LA PRUEBA TEMPORAL DE SUGERENCIAS */
  /*
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implementar la acción que muestra las sugerencias según se teclea un término

    final listaSugerencias = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where((peli) => peli.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      // itemCount: peliculasRecientes.length,
      itemCount: listaSugerencias.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.movie),
          // title: Text(peliculasRecientes[index]),
          title: Text(listaSugerencias[index]),
          onTap: () {},
        );
      },
    );
  }
  */
}
