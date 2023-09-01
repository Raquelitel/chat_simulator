import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;
  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
// --------- Para controlar el texto del input donde lo llamamos --------
    final textController = TextEditingController();

    final focusNode = FocusNode();

// ----- Creamos styles comunes para utilizar en varios widget -------
    final outlineInputBorder = UnderlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.transparent));

    final inputDecoration = InputDecoration(
        hintText: 'aquí placeholder',
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {
            final textValue = textController.value.text;
            textController.clear();
            onValue(textValue);
          },
        ));

    return TextFormField(
      // para quitar el focus al salir del input
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      // para mantener el focus en el input después de hacer submit
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        onValue(value);
        textController.clear();
        // para mantener el foco
        focusNode.requestFocus();
      },
    );
  }
}
