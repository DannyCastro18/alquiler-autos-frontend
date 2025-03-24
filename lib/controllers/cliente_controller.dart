import 'dart:convert'; //permite codificar y decodificar datos en formato JSON
import 'package:http/http.dart' as http;

//definir una clase para poder trabajar a cliente

class ClienteService {
  final String baseUrl =
      'https://backendalquilerautos.onrender.com/api/clientes'; //url de la API -> cambiar

  //Metodo registrar cliente
  Future<http.Response> registrarCliente(
      String nombre, String correo, String numeroLicencia, password) async {
    final url = Uri.parse('$baseUrl/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'correo': correo,
        'numeroLicencia': numeroLicencia,
        'password': password,
      }),
    );
    return response;
  }

  // Metodo para login

  Future<Map<String, dynamic>> loginCliente(
      String correo, String password) async {
    final url = Uri.parse(
        'https://backendalquilerautos.onrender.com/api/login'); //url de la API -> cambiar
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'correo': correo,
        'password': password,
      }),
    );

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {
        'success': true,
        'mensaje': responseData['mensaje'],
        'cliente': responseData['cliente']
      };
    } else {
      return {
        'success': false,
        'mensaje': responseData['mensaje'] ?? 'Credenciales incorrectas'
      };
    }
  }
}
