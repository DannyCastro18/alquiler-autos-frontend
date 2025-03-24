import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos/controllers/cliente_controller.dart';
import 'package:flutter_alquiler_autos/views/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _numeroLicenciaController =
      TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllervalida =
      TextEditingController();
  final ClienteService clienteService = ClienteService();

  void registrarCiente() async {
    print('boton de registro'); //revisar, cambie nombre
    final nombre = _nombreController.text;
    final numeroLicencia = _numeroLicenciaController.text;
    final correo = _correoController.text;
    final password = _passwordController.text;
    final passwordvalida = _passwordControllervalida.text;

    if (password != passwordvalida) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }
    try {
      final response = await clienteService.registrarCliente(
          nombre, correo, numeroLicencia, password);

      print('Status codigo: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro exitoso')),
        );
        // Limpiar los campos dentro de setState para reflejar cambios en la UI
        setState(() {
          _nombreController.clear();
          _correoController.clear();
          _numeroLicenciaController.clear();
          _passwordController.clear();
          _passwordControllervalida.clear();
        });

        // Navegar a la pantalla de login
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar')),
        );
      }
    } catch (e) {
      print("Error en el registro: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la conexion con el servidor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icono en la parte superior
              Icon(
                Icons.person_add,
                size: 80,
                color: Colors.red[300],
              ),
              SizedBox(height: 16.0),
              // Texto "Empecemos"
              Text(
                "Empecemos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[300],
                ),
              ),
              SizedBox(height: 8.0),
              // Texto "Crear una nueva cuenta"
              Text(
                "Crear una nueva cuenta",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 32.0),
              // Campo de nombre completo
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              // Campo numero licencia
              TextField(
                controller: _numeroLicenciaController,
                decoration: InputDecoration(
                  labelText: 'Número de licencia', //aqui
                  prefixIcon:
                      Icon(Icons.account_balance_rounded, color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
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
              SizedBox(height: 16.0),
              // Campo de confirmación de contraseña
              TextField(
                controller: _passwordControllervalida,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32.0),
              // Botón de registro
              ElevatedButton(
                onPressed: () {
                  registrarCiente();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[300],
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16.0),
              // Texto para iniciar sesión
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("¿Ya tienes una cuenta? "),
                  GestureDetector(
                    onTap: () {
                      // Acción para redirigir al inicio de sesión
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Iniciar sesión",
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
      ),
    );
  }
}
