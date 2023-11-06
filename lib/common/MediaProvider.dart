import 'package:dmi_moviedb_practica14_200527_flutter/model/Cast.dart';
import 'package:dmi_moviedb_practica14_200527_flutter/model/Media.dart';
import 'package:dmi_moviedb_practica14_200527_flutter/common/HttpHandler.dart';
import 'dart:async';

abstract class MediaProvider {
  Future<List<Media>> fetchMedia(String category);
  Future<List<Cast>> fetchCast(int mediaId);
}

class MediaPrvider extends MediaProvider {
  HttpHandler _client = HttpHandler.get();
  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchMovies(category: category);
  }

  @override
  Future<List<Cast>> fetchCast(int mediaId) {
    return _client.fetchCreditMovies(mediaId);
  }
}

class ShowProvider extends MediaProvider {
  HttpHandler _client = HttpHandler.get();
  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchShow(category: category);
  }

  @override
  Future<List<Cast>> fetchCast(int mediaId) {
    return _client.fetchCreditShows(mediaId);
  }
}
