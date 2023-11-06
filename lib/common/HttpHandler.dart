// Creado por: Uriel Maldonado Cortez
// Asignatura: Desarrollo Movil Integral
//Grado: 10   Grupo: "A"
// Docente: MTI. Marco Antonio Ramirez Hernandez
import 'dart:async'; // Importa la biblioteca para manejar operaciones asíncronas.
import 'dart:convert'; // Importa la biblioteca para codificar y decodificar JSON.
import 'package:http/http.dart'
    as http; // Importa la biblioteca para realizar solicitudes HTTP.
import 'package:dmi_moviedb_practica14_200527_flutter/common/Constants.dart'; // Importa un archivo Constants.dart.
import 'package:dmi_moviedb_practica14_200527_flutter/model/Cast.dart';
import 'package:dmi_moviedb_practica14_200527_flutter/model/Media.dart'; // Importa la definición de la clase Media.

class HttpHandler {
  static final _httHandler = HttpHandler();
  final String _baseUrl = "api.themoviedb.org"; // Define la URL base de la API.
  final String _language =
      "es-MX"; // Define el lenguaje deseado para las respuestas.

  static HttpHandler get() {
    return _httHandler;
  }

  // Define una función asincrónica para obtener datos JSON desde una URI.
  Future<dynamic> getJson(Uri uri) async {
    http.Response response =
        await http.get(uri); // Realiza una solicitud GET HTTP.
    return json.decode(response.body); // Decodifica la respuesta JSON.
  }

  Future<List<Media>> fetchMovies({String category = "populares"}) async {
    var uri = Uri.https(
      _baseUrl,
      "3/movie/$category",
      {
        'api_key': API_KEY,
        'page': "1",
        'language': _language,
      },
    );

    return getJson(uri).then((data) {
      if (category == "upcoming") {
        var sortedResults = data['results']
            .where((item) => item['release_date'] != null)
            .toList()
          ..sort((a, b) {
            DateTime dateA = DateTime.parse(a['release_date']);
            DateTime dateB = DateTime.parse(b['release_date']);
            return dateB.compareTo(dateA);
          });

        return sortedResults
            .map<Media>((item) => Media(item, MediaType.movie))
            .toList();
      } else {
        return data['results']
            .map<Media>((item) => Media(item, MediaType.movie))
            .toList();
      }
    });
  }

  Future<List<Media>> fetchShow({String category = "populares"}) async {
    var uri = Uri.https(_baseUrl, "3/tv/$category", {
      'api_key': API_KEY,
      'page': "1",
      'language': _language
    }); // Parámetros de la solicitud.
    // Llama a la función getJson para obtener datos y mapearlos en objetos de tipo Media.
    return getJson(uri).then(((data) => data['results']
        .map<Media>((item) => Media(item, MediaType.show))
        .toList()));
  }

  Future<List<Cast>> fetchCreditMovies(int mediaId) async {
    var uri = Uri.https(_baseUrl, "3/movie/$mediaId/credits", {
      'api_key': API_KEY,
      'page': "1",
      'language': _language
    }); // Parámetros de la solicitud.
    // Llama a la función getJson para obtener datos y mapearlos en objetos de tipo Media.
    return getJson(uri).then(((data) => data['cast']
        .map<Cast>((item) => Cast(item, MediaType.movie))
        .toList()));
  }

  Future<List<Cast>> fetchCreditShows(int mediaId) async {
    var uri = Uri.https(_baseUrl, "3/tv/$mediaId/credits", {
      'api_key': API_KEY,
      'page': "1",
      'language': _language
    }); // Parámetros de la solicitud.
    // Llama a la función getJson para obtener datos y mapearlos en objetos de tipo Media.
    return getJson(uri).then(((data) =>
        data['cast'].map<Cast>((item) => Cast(item, MediaType.show)).toList()));
  }
}
