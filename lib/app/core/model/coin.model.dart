import 'package:cumbu/app/core/utils/map_extension.dart';

List<Coin> coinsFromListDynamic(Map<String, dynamic> map) {
  if (map.hasKeyAndIsList('genericResponse')) {
    final list = map['genericResponse'] as List<dynamic>;
    final coins = <Coin>[];

    for (final item in list) {
      final coin = Coin.fromMap(item as Map<String, dynamic>);
      coins.add(coin);
    }

    return coins;
  }

  return <Coin>[];
}

class Coin {
  final double? tax;
  final double? amountToConvert;
  final double? amoutConverted;
  final String? description;
  final String? code;
  final DateTime? date;

  Coin({
    this.tax,
    this.amountToConvert,
    this.amoutConverted,
    this.description,
    this.code,
    this.date,
  });

  factory Coin.fromMap(Map<String, dynamic> map) {
    return Coin(
      tax: map.hasKeyAndIsDouble('taxa') ? map['taxa'] as double : null,
      description: map.hasKeyAndIsString('descricaoTipoCambio') ? map['descricaoTipoCambio'] as String : null,
      code: map.hasKeyAndIsString('codigoMoeda') ? map['codigoMoeda'] as String : null,
      amountToConvert: map.hasKeyAndIsDouble('montante') ? map['montante'] as double : null,
      amoutConverted: map.hasKeyAndIsDouble('montanteConvertido') ? map['montanteConvertido'] as double : null,
      date: DateTime.now(),
    );
  }
}
