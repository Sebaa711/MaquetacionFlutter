import 'package:flutter/material.dart';

class CajaDeTexto extends StatelessWidget {
  const CajaDeTexto({super.key});

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    final inputDecoration = InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
            onPressed: () {
              print("Valor de caja de texto?");
            },
            icon: const Icon(Icons.send_outlined)));

    return TextFormField(
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        print('Enviar valor $value');
      },
      onChanged: (value) {
        print('Cambiado: $value');
      },
    );
  }
}
