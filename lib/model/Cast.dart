import 'package:dmi_moviedb_practica14_200527_flutter/common/Util.dart';
import 'package:dmi_moviedb_practica14_200527_flutter/model/Media.dart';

class Cast {
  int id;
  String name;
  String profilePath;

  String getCastUrl() => getMediumPictureUrl(profilePath);

  factory Cast(Map jsonMap, MediaType mediaType) {
    try {
      return new Cast.deserialize(jsonMap, mediaType);
    } catch (ex) {
      throw ex;
    }
  }

  Cast.deserialize(Map jsonMap, MediaType mediaType)
      : id = jsonMap["cast_id"].toInt(),
        name = jsonMap["name"],
        profilePath = jsonMap["profile_path"] ?? "assets/poster.jpg";
}
