import 'package:flutter/material.dart';

class MenuDrawerPerfil extends StatefulWidget {
  @override
  _MenuDrawerPerfilState createState() => _MenuDrawerPerfilState();
}

class _MenuDrawerPerfilState extends State<MenuDrawerPerfil> {
  // Controlador para el campo de texto de revisión de alquileres
  final TextEditingController _rentalController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador al salir de la pantalla
    _rentalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.red[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Volver al menú principal
            ListTile(
              leading: Icon(Icons.arrow_back, color: Colors.grey[700]),
              title: Text("Volver al menú principal"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Foto de perfil
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    AssetImage('assets/profile_pic.jpg'), // Imagen de ejemplo
              ),
            ),
            SizedBox(height: 16.0),
            // Nombre y correo
            Center(
              child: Column(
                children: [
                  Text(
                    "Nombre de Usuario",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    "correo@example.com",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            // Información de perfil
            ListTile(
              leading: Icon(Icons.badge, color: Colors.grey[700]),
              title: Text("Número de licencia"),
              subtitle: Text("123456789"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.grey[700]),
              title: Text("Cambiar contraseña"),
              onTap: () {
                // Acción para cambiar contraseña
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.search_rounded, color: Colors.red[700]),
              title: Text("Revisar Alquileres"),
              onTap: () {
                // Acción para revisar alquileres
              },
            ),
            SizedBox(height: 16.0),

            // Botón para ir al login
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/'); // Redirige al login
                },
                icon: Icon(Icons.exit_to_app),
                label: Text("Cerrar sesión"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
