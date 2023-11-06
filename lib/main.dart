import 'package:flutter/material.dart'; // Importa la biblioteca Flutter para construir interfaces de usuario
import 'package:dmi_moviedb_practica14_200527_flutter/home.dart'; // Importa el archivo home.dart que contiene la definición de la clase Home

void main() {
  // Función principal del programa
  runApp(MaterialApp(
    // Inicializa la aplicación Flutter
    debugShowCheckedModeBanner:
        false, // Desactiva la etiqueta de depuración en la esquina superior derecha de la aplicación
    home:
        Home(), // Define la pantalla de inicio de la aplicación como una instancia de la clase Home
    theme: ThemeData
        .dark(), // Establece el tema de la aplicación como un tema oscuro
  ));
}
