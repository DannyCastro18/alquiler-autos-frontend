import 'dart:convert';
import 'package:http/http.dart' as http;

class AlquilerService {
  final String baseUrl =
      "https://backendalquilerautos.onrender.com/api/alquiler"; //url de la API -> cambiar
  // Método para registrar un alquiler
  Future<Map<String, dynamic>> registrarAlquiler(
      int clienteId, int autoId, String fechaInicio, String fechaFin) async {
    try {
      final url = Uri.parse('$baseUrl/');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'clienteId': clienteId,
          'autoId': autoId,
          'fechaInicio': fechaInicio,
          'fechaFin': fechaFin,
        }),
      );

      print('Respuesta del servicio: $clienteId');
      print(
          'cliente: $clienteId, autoId: $autoId, fechaInicio: $fechaInicio, fechaFin: $fechaFin');

      if (response.statusCode == 200) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['mensaje'] ??
              'Error al registrar el alquiler',
        };
      }
    } catch (e) {
      print('Error en registrar alquiler: $e');
      return {'success': false, 'message': 'Error al registrar el alquiler'};
    }
  }
}
