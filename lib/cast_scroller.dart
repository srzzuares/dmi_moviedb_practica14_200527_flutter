import 'package:flutter/material.dart';
import 'package:dmi_moviedb_practica14_200527_flutter/common/MediaProvider.dart';
import 'package:dmi_moviedb_practica14_200527_flutter/model/Cast.dart';

class CastController extends StatefulWidget {
  final MediaProvider provider;
  final int mediaId;

  CastController(this.provider, this.mediaId);

  @override
  _CastControllerState createState() => new _CastControllerState();
}

class _CastControllerState extends State<CastController> {
  @override
  void initState() {
    super.initState();
    loadCast();
  }

  final List<Cast> _cast = [];
  void loadCast() async {
    var results = await widget.provider.fetchCast(widget.mediaId);

    setState(() {
      _cast.addAll(results);
    });
  }

  Widget _builderCasts(BuildContext ctx, int index) {
    var cast = _cast[index];
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(children: <Widget>[
        CircleAvatar(
          backgroundImage: new NetworkImage(cast.getCastUrl()),
          radius: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(cast.name),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      SizedBox.fromSize(
        size: const Size.fromHeight(180.0),
        child: ListView.builder(
          itemCount: _cast.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 12.0, left: 20.0),
          itemBuilder: _builderCasts,
        ),
      )
    ]);
  }
}
