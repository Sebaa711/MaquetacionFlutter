import 'package:flutter/material.dart';
import 'package:si_no_app/presentacion/widgets/chat/mi_mensaje_burbuja.dart';
import 'package:si_no_app/presentacion/widgets/chat/su_mensaje_burbuja.dart';
import 'package:si_no_app/presentacion/widgets/chat/compartido/caja_de_texto.dart';

class ChatPantalla extends StatelessWidget {
  const ChatPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSbxmzvX60Xz0zJGdFfc_OiP_djcpzUkJ7GKQBc35uUfh-bYxjb"),
          ),
        ),
        title: const Text("Emilia"),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: 100,
                        itemBuilder: (context, index) => index % 2 == 0
                            ? const SuMensajeBurbuja()
                            : const MiMensajeBurbuja())),
                const CajaDeTexto(),
              ],
            )));
  }
}
