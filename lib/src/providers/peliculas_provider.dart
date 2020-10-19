import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:async';
import 'package:flutt_pelis/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '1317b2225ba500e104112c9f5c2e0c71';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

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
}
