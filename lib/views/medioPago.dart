import 'package:flutter/material.dart';

class medioPago extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medio de Pago'),
        backgroundColor: Colors.red[300],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Opción de Tarjeta de Crédito o Débito
          ListTile(
            leading: Icon(Icons.credit_card, color: Colors.red[400]),
            title: Text(
              'Tarjeta de crédito o débito',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Acción para seleccionar este método de pago
            },
            tileColor: Colors.red[50],
          ),
          Divider(),
          // Opción de PayPal
          ListTile(
            leading: Icon(Icons.account_balance_wallet, color: Colors.red),
            title: Text(
              'PayPal',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Acción para seleccionar PayPal
            },
          ),
          Divider(),
          // Opción de Transferencia Bancaria
          ListTile(
            leading: Icon(Icons.account_balance, color: Colors.red),
            title: Text(
              'Transferencia bancaria',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Acción para seleccionar Transferencia Bancaria
            },
          ),
        ],
      ),
    );
  }
}
