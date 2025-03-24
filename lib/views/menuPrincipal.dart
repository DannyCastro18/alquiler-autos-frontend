import 'dart:async'; // Importa la librería para usar Timer
import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos/controllers/autos_controller.dart';
import 'package:flutter_alquiler_autos/views/detalleVehiculo.dart';
import 'package:flutter_alquiler_autos/views/menuDrawerPerfil.dart';

class MenuPrincipal extends StatefulWidget {
  final int clienteId;
  MenuPrincipal({Key? key, required this.clienteId}) : super(key: key);

  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  final AutosController autosController = AutosController();
  List<Map<String, dynamic>> listaDeAutos = [];
  bool isLoading = true;
  Timer? _timer; // Timer para el polling

  @override
  void initState() {
    super.initState();
    cargarAutos();

    // Configurar el polling para actualizar los datos cada 5 segundos
    _timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      cargarAutos();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el timer cuando la pantalla se destruye
    super.dispose();
  }

  void cargarAutos() async {
    try {
      final autos = await autosController.obtenerAutosDisponibles();
      setState(() {
        listaDeAutos = autos;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error al cargar autos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawerPerfil(),
      appBar: AppBar(
        title: Text('Alquiler de Vehículos'),
        backgroundColor: Colors.red[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Buscar vehículo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : listaDeAutos.isEmpty
                      ? Center(child: Text('No hay vehículos disponibles'))
                      : ListView.builder(
                          itemCount: listaDeAutos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.network(
                                listaDeAutos[index]['imageUrl'] ??
                                    'https://via.placeholder.com/60', // Imagen por defecto si es nulo
                                width: 60,
                                height: 50,
                                fit: BoxFit
                                    .cover, // Ajustar imagen correctamente
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.directions_car,
                                      size: 50, color: Colors.red[300]);
                                }, // Si hay error, mostrar un ícono de auto
                              ),
                              title: Text(
                                  '${listaDeAutos[index]['marca']} ${listaDeAutos[index]['modelo']}'),
                              subtitle: Text(
                                  'Año: ${listaDeAutos[index]['year']} - ${listaDeAutos[index]['valorAlquiler']}'),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Colors.red[300]),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetalleVehiculoScreen(
                                      imageUrl: listaDeAutos[index]
                                              ['imageUrl'] ??
                                          'https://via.placeholder.com/600',
                                      marca: listaDeAutos[index]['marca'],
                                      modelo: listaDeAutos[index]['modelo'],
                                      year: listaDeAutos[index]['year'],
                                      estado: listaDeAutos[index]['estado'],
                                      autoId: listaDeAutos[index]['id'],
                                      clienteId: widget.clienteId,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red[300],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), label: 'Alquiler'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuario'),
        ],
      ),
    );
  }
}
