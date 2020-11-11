import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:flutt_pelis/src/models/pelicula_model.dart';
import 'package:flutt_pelis/src/models/actores_model.dart';

class PeliculasProvider {
  String _apikey = '1317b2225ba500e104112c9f5c2e0c71';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  /*
  // CON EL CÓDIGO OPTIMIZADO
  // ============================================================ */

  /*
  // Optimizado :: Forma 2d2
  // ============================================================ */
  Future<List<Pelicula>> getEnCines() async =>
    await _getPeliculasList('/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

  // Future<List<Pelicula>> getPopulares() =>
  //     _getPeliculasList('/movie/now_playing', {
  //       'api_key': _apikey,
  //       'language': _language,
  //     });

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    print('Cargando siguientes ...');

    final resp = await _getPeliculasList('/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;

    return resp;

    // return await _getPeliculasList('/movie/now_playing', {
    //   'api_key': _apikey,
    //   'language': _language,
    //   'page': _popularesPage.toString(),
    // });
  }

  Future<List<Pelicula>> _getPeliculasList(
      String urlSubPath, Map<String, String> params) async {
    final url = Uri.https(_url, '3$urlSubPath', params);

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Actor>> getCast(String peliculaId) async {
    final url = Uri.https(_url, '3/movie/$peliculaId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  // Para optimizar la carga del listado de populares al cargar o volver al HOME
  int getTotPopularesCargadas() => _populares.length;

  Future<List<Pelicula>> searchMovie(String query) async =>
    await _getPeliculasList('/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query,
    });

  /*
  // Optimizado :: Forma 1d2
  // ============================================================ */
  /*
  Future<List<Pelicula>> _getPeliculasList(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _getPeliculasList(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _getPeliculasList(url);
  }
  */

  /*
  // SIN EL CÓDIGO OPTIMIZADO
  // ============================================================ */
  /*
  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    // Todo el objeto resultante:
    // print(decodedData);
    // Todo el contenido del objeto resultante:
    //print(decodedData['results']);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    //print('-> Tít película: ' + peliculas.items[0].title);

    // return [];
    return peliculas.items;
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }
  */
}
