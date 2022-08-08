import 'package:flutter/material.dart';

progressBar() {
  return Center(
    child: Column(
      children: const [
        SizedBox(height: 100.0),
        CircularProgressIndicator(),
        SizedBox(height: 10.0),
        Text(
          'Carregando, por favor aguarde...',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
