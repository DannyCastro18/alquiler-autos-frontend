import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos/controllers/cliente_controller.dart';
import 'package:flutter_alquiler_autos/views/menuPrincipal.dart';
import 'package:flutter_alquiler_autos/views/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ClienteService clienteService = ClienteService();

  void iniciarSesion() async {
    final correo = _correoController.text;
    final password = _passwordController.text;

    final result = await clienteService.loginCliente(correo, password);

    if (result['success'] && result.containsKey('cliente')) {
      final clienteId = result['cliente']['id'];
      //verificar que el usuario tiene datos validos antes de ir a iniicar sesion
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Inicio de sesión exitoso')));
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MenuPrincipal(clienteId: clienteId)),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Credenciales mal x_X')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icono en la parte superior
            Icon(
              Icons.person,
              size: 80,
              color: Colors.red[300],
            ),
            SizedBox(height: 16.0),
            // Texto de bienvenida
            Text(
              "Bienvenido",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red[300],
              ),
            ),
            SizedBox(height: 8.0),
            // Subtítulo
            Text(
              "Inicia sesión para continuar con tu alquiler",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32.0),
            // Campo de correo electrónico
            TextField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            // Campo de contraseña
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            // Botón de inicio de sesión
            ElevatedButton(
              onPressed: () {
                iniciarSesion();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[300],
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Iniciar sesión',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            // Texto para recuperar contraseña
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  "¿Olvidaste tu contraseña? ",
                  textAlign: TextAlign.center,
                )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuPrincipal(clienteId: 0)));
                  },
                  child: Text(
                    "Recuperar",
                    style: TextStyle(
                      color: Colors.red[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            // Texto para registrarse
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("¿No tienes una cuenta? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: Text(
                    "Regístrate",
                    style: TextStyle(
                      color: Colors.red[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
