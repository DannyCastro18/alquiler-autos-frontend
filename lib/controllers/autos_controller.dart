import 'dart:convert'; //permite codificar y decodificar datos en formato JSON
import 'package:http/http.dart' as http;

class AutosController {
  final String baseUrl =
      "https://alquiler-autos-dusw.onrender.com/api/autos"; 

  //metodo para obtener los vehiculos disponibles
  Future<List<Map<String, dynamic>>> obtenerAutosDisponibles() async {
    //retorna una lista de mapas,cada mapa representa un auto
    try {
      //utilizar el metodo con las funciones para detectar errores
      final url = Uri.parse('$baseUrl');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        //Convertir los datos a lista de mapas
        return data.map((auto) {
          //mapear los datos que los recorre de la lista de autos
          return {
            'id': auto['id'],
            'marca': auto['marca'],
            'modelo': auto['modelo'],
            'imageUrl': auto['imageUrl'] ??
                'https://img.freepik.com/psd-gratis/elegante-sedan-deportivo-rojo-aislado-sobre-fondo-transparente-que-muestra-su-diseno-moderno-caracteristicas-lujo-imagen-perfecta-publicidad-automotriz-o-proyectos-diseno_632498-27351.jpg',
            'valorAlquiler': auto['valorAlquiler'],
            'year': auto['year'],
            'estado': auto['estado'],
          };
        }).toList();
      } else {
        throw Exception('Error al obtener los vehiculos');
      }
    } catch (e) {
      print('Error en obtener Autos: $e');
      return [];
    }
  }
}
