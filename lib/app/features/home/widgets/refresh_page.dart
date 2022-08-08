import 'package:flutter/material.dart';

Widget refreshPage(Function f) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 100.0),
      const Text(
        'Não foi possível acessar o servidor, tente novamente',
        style: TextStyle(
          color: Colors.amber,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 20.0),
      IconButton(
        onPressed: () => f(),
        icon: const Icon(
          Icons.refresh,
          size: 34,
          color: Colors.amber,
        ),
      ),
    ],
  );
}
