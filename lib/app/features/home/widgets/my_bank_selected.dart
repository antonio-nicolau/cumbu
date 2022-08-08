import 'package:cumbu/app/core/controller/calc_controller.dart';
import 'package:cumbu/app/core/model/coin.model.dart';
import 'package:flutter/material.dart';

Widget exchangeResultWidget(BuildContext context, Coin? coin) {
  final result = CalcController().toMoneyFormat((coin?.amoutConverted ?? 0.0).toString());

  return Container(
    padding: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.amber,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8)),
    child: Text(
      result ?? '',
      style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.amber),
      textAlign: TextAlign.center,
    ),
  );
}
