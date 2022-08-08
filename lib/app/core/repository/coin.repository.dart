import 'dart:convert';
import 'dart:io';
import 'package:cumbu/app/core/model/coin.model.dart';
import 'package:cumbu/app/core/model/coin.param.dart';
import 'package:http/http.dart' as http;
import 'package:cumbu/app/core/utils/map_extension.dart';

abstract class ICoinRepository {
  Future<List<Coin>?> convertCoin(CoinQueryParam param);
  Future<List<Map<String, dynamic>>> getAvailableCoins();
}

class CoinRepository implements ICoinRepository {
  @override
  Future<List<Coin>?> convertCoin(CoinQueryParam param) async {
    final uri = Uri(
      scheme: 'https',
      host: 'www.bna.ao',
      path: '/service/rest/taxas/conversor/moeda',
      queryParameters: param.toMap(),
    );
    final response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      final result = json.decode(response.body) as Map<String, dynamic>;

      if (result.hasKeyAndIsList('genericResponse')) {
        return coinsFromListDynamic(result);
      }
    }
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> getAvailableCoins() async {
    final uri = Uri(
      scheme: 'https',
      host: 'www.bna.ao',
      path: '/service/rest/taxas/get/lista/moedas',
    );
    final response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      final result = json.decode(response.body) as Map<String, dynamic>;

      if (result.hasKeyAndIsList('genericResponse')) {
        return coinsAvailablesFromListDynamic(result);
      }
    }
    return <Map<String, dynamic>>[];
  }
}

List<Map<String, dynamic>> coinsAvailablesFromListDynamic(Map<String, dynamic> map) {
  if (map.hasKeyAndIsList('genericResponse')) {
    final list = map['genericResponse'] as List<dynamic>;
    final coins = <Map<String, dynamic>>[];

    for (final item in list) {
      final coin = item as Map<String, dynamic>;
      coins.add(coin);
    }

    return coins;
  }

  return <Map<String, dynamic>>[];
}
