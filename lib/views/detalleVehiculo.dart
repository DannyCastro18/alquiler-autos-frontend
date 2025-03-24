import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos/views/medioPago.dart';
import 'package:flutter_alquiler_autos/controllers/alquiler_controller.dart';

class DetalleVehiculoScreen extends StatefulWidget {
  final String imageUrl;
  final String marca;
  final String modelo;
  final String year;
  final int estado;
  final int autoId;
  final int clienteId;

  DetalleVehiculoScreen({
    Key? key,
    required this.imageUrl,
    required this.marca,
    required this.modelo,
    required this.year,
    required this.estado,
    required this.autoId,
    required this.clienteId,
  }) : super(key: key);

  @override
  _DetalleVehiculoScreenState createState() => _DetalleVehiculoScreenState();
}

class _DetalleVehiculoScreenState extends State<DetalleVehiculoScreen> {
  late bool disponible;

  @override
  void initState() {
    super.initState();
    // Inicializar la variable disponible basada en la disponibilidad del vehiculo
    disponible = widget.estado > 0;
  }

  void alquilarVehiculo() async {
    final alquilerService = AlquilerService();

    final String fechaInicio = DateTime.now().toUtc().toIso8601String();
    final String fechaFin =
        DateTime.now().add(Duration(days: 7)).toUtc().toIso8601String();

    print('Fecha inicio: $fechaInicio');
    print('Fecha fin: $fechaFin');
    print('Cliente ID: ${widget.clienteId}');
    print('Auto ID: ${widget.autoId}');

    try {
      final response = await alquilerService.registrarAlquiler(
        widget.clienteId,
        widget.autoId,
        fechaInicio,
        fechaFin,
      );

      print('Respuesta del servicio: $response');

      if (response['success']) {
        if (response.containsKey('data') &&
            response['data'] is Map &&
            response['data'].containsKey('mensaje')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['data']['mensaje'])),
          );
        } else {
          setState(() {
            disponible = false; // Actualiza la disponibilidad
          });
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alquiler completado')),
        );
      }
    } catch (e) {
      print('Error al registrar alquiler: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar el alquiler')),
      );
    }
  }

  void confirmarAlquiler() {
    print('Confirmar alquiler llamado');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmar alquiler'),
            content: Text('¿Desea alquilar este vehículo?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  print('Alquiler confirmado');
                  alquilarVehiculo();
                },
                child: Text('Confirmar'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del vehículo'),
        backgroundColor: Colors.red[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del vehículo
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Marca
            Text(
              'Marca: ${widget.marca}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            // Modelo
            Text(
              'Modelo: ${widget.modelo}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8.0),
            // Año
            Text(
              'Año: ${widget.year}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8.0),
            // Disponibilidad
            Text(
              'Disponibilidad: ${disponible ? 'Disponible' : 'No Disponible'}',
              style: TextStyle(
                fontSize: 16,
                color: disponible ? Colors.green : Colors.red,
              ),
            ),
            Spacer(),
            // Botón de Alquilar Vehículo
            Center(
              child: ElevatedButton.icon(
                onPressed: disponible ? confirmarAlquiler : null,
                icon: Icon(Icons.directions_car),
                label: Text('Alquilar Vehículo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: disponible ? Colors.red[300] : Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
