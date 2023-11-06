// Creado por: Uriel Maldonado Cortez
// Asignatura: Desarrollo Movil Integral
//Grado: 10   Grupo: "A"
// Docente: MTI. Marco Antonio Ramirez Hernandez
import 'package:flutter/material.dart'; // Importa la biblioteca Flutter para construir interfaces de usuario.
import 'package:dmi_moviedb_practica14_200527_flutter/media_detail.dart';
import 'package:dmi_moviedb_practica14_200527_flutter/model/Media.dart'; // Importa la clase Media desde un archivo llamado Media.dart.
import 'package:dmi_moviedb_practica14_200527_flutter/media_list_item.dart';
import 'package:dmi_moviedb_practica14_200527_flutter/common/MediaProvider.dart';

// ignore: must_be_immutable
class MediaList extends StatefulWidget {
  final MediaProvider provider;
  String category;
  MediaList(this.provider, this.category);
  @override
  _MediaListState createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  List<Media> _media = [];

  @override
  void initState() {
    super.initState();
    loadMedia();
  }

  @override
  void didUpdateWidget(MediaList oldWidget) {
    if (oldWidget.provider.runtimeType != widget.provider.runtimeType) {
      _media = [];
      loadMedia();
    }
    super.didUpdateWidget(oldWidget);
  }

  void loadMedia() async {
    var media = await widget.provider.fetchMedia(widget.category);
    setState(() {
      _media.addAll(media);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _media.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(8), // Establece el margen aquí
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MediaDetail(_media[index], widget.provider);
                }));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 0, 0).withOpacity(
                    0.2), // Cambia el color y la transparencia aquí
              ),
              child: MediaListItem(_media[index]),
            ),
          );
        },
      ),
    );
  }
}
