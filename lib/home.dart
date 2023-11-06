// Creado por: Crystian Enrique Suarez Cuevas
// Asignatura: Desarrollo Movil Integral
//Grado: 10   Grupo: "A"
// Docente: MTI. Marco Antonio Ramirez Hernandez
import 'package:flutter/material.dart'; // Importa la biblioteca Flutter para construir interfaces de usuario.
import 'package:dmi_moviedb_practica14_200527_flutter/media_list.dart';
import 'package:dmi_moviedb_practica14_200527_flutter/common/MediaProvider.dart';
import 'package:dmi_moviedb_practica14_200527_flutter/model/Media.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key}); // Constructor de Home con un parámetro opcional llamado key.
  @override
  State<Home> createState() =>
      _HomeState(); // Define una clase que extiende StatefulWidget y proporciona un método para crear su estado interno.
}

class _HomeState extends State<Home> {
  // Define una clase que extiende State y representa el estado interno de Home.

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  final MediaProvider movieProvider = MediaPrvider();
  final MediaProvider showProvider = ShowProvider();
  PageController? _pageController;
  int _page = 0;

  MediaType mediaType = MediaType.movie;
  // Estilo de fuente personalizado
  final TextStyle customTextStyle = TextStyle(
    fontFamily: 'MiFuente', // Nombre de la fuente definido en pubspec.yaml
    fontSize: 16.0, // Tamaño de fuente deseado
    fontWeight: FontWeight
        .bold, // Puedes ajustar el peso de la fuente según tus preferencias
  );

  @override
  Widget build(BuildContext context) {
    // Crear una página Scaffold que contiene la estructura principal de la aplicación
    return Scaffold(
      appBar: AppBar(
        // Barra de navegación superior (AppBar) con un título y un botón de búsqueda
        title: Text("Peliquiando 200527"), // Título de la aplicación
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // Acción a ejecutar cuando se presiona el botón de búsqueda
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Menú lateral (Drawer) que se despliega desde el borde izquierdo
        child: ListView(children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Menú',
                style: TextStyle(
                  backgroundColor: Colors.black38,
                  color: Colors.black38,
                  fontSize: 24,
                ),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/poster.jpg'), fit: BoxFit.cover)),
          ),
          // Elemento del menú "peliculas"
          ListTile(
            title: Text(
              "peliculas",
              style:
                  customTextStyle, // Aplica el estilo de fuente personalizado
            ),
            selected: mediaType == MediaType.movie,
            trailing: Image.asset('assets/1.png', width: 45, height: 45),

            onTap: () {
              _changeMediaType(MediaType.movie);
              Navigator.of(context).pop();
            }, // Icono de películas
          ),

          // Separador en el menú
          Divider(
            height: 5.0,
          ),

          // Elemento del menú "Television"
          ListTile(
            title: Text(
              "Television",
              style:
                  customTextStyle, // Aplica el estilo de fuente personalizado
            ),
            trailing: Image.asset('assets/2.png',
                width: 45, height: 45), // Icono de películas
            onTap: () {
              _changeMediaType(MediaType.show);
              Navigator.of(context).pop();
            }, // Icono de películas
          ),
          // Separador en el menú
          Divider(
            height: 5.0,
          ),

          // Elemento del menú "Cerrar"
          ListTile(
            title: Text(
              "Cerrar",
              style:
                  customTextStyle, // Aplica el estilo de fuente personalizado
            ),
            trailing: Image.asset('assets/3.png',
                width: 45, height: 45), // Icono de películas
            // Icono de televisión
            onTap: () => Navigator.of(context)
                .pop(), // Cierra el menú al tocar este elemento
          ),
        ]),
      ),
      body: PageView(
        children: _getMediaList(),
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Barra de navegación inferior (BottomNavigationBar) con iconos y etiquetas
        items: _obtenerIconos(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  // Método para obtener los elementos de la barra de navegación inferior
  List<BottomNavigationBarItem> _obtenerIconos() {
    return mediaType == MediaType.movie
        ? [
            BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up), // Icono de pulgar hacia arriba
              label: ("populares"), // Etiqueta para la opción "populares"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.update), // Icono de actualización
              label: ("Proximamente"), // Etiqueta para la opción "Proximamente"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star), // Icono de estrella
              label:
                  ("Mejor valoradas"), // Etiqueta para la opción "Mejor valorados"
            ),
          ]
        : [
            BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up), // Icono de pulgar hacia arriba
              label: ("populares"), // Etiqueta para la opción "populares"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.update), // Icono de actualización
              label: ("Aire"), // Etiqueta para la opción "Proximamente"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star), // Icono de estrella
              label:
                  ("Mejor valoradas"), // Etiqueta para la opción "Mejor valorados"
            )
          ];
  }

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<Widget> _getMediaList() {
    return (mediaType == MediaType.movie)
        ? <Widget>[
            MediaList(movieProvider, "popular"),
            MediaList(movieProvider, "upcoming"),
            MediaList(movieProvider, "top_rated")
          ]
        : <Widget>[
            MediaList(showProvider, "popular"),
            MediaList(showProvider, "on_the_air"),
            MediaList(showProvider, "top_rated")
          ];
  }

  void _navigationTapped(int page) {
    _pageController?.animateToPage(
      page,
      duration: const Duration(
          milliseconds:
              300), // Aumenta la duración de la animación a 300 milisegundos
      curve: Curves
          .easeInOut, // Cambia la curva de la animación para que sea más suave
    );
  }
}
