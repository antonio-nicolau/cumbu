import 'dart:developer';
import 'package:cumbu/app/core/model/coin.model.dart';
import 'package:cumbu/app/core/model/coin.param.dart';
import 'package:cumbu/app/core/repository/coin.repository.dart';
import 'package:flutter/cupertino.dart';

enum RequestState { none, loading, success, error }

class CoinService extends ChangeNotifier {
  final ICoinRepository _coinRepository;
  List<Coin>? coins;
  List<Map<String, dynamic>>? availablesCoin;
  RequestState? _requestState;

  CoinService(this._coinRepository);

  RequestState get requestState => _requestState ?? RequestState.none;

  Future<List<Coin>?> convertCoin(CoinQueryParam param) async {
    try {
      _requestState = RequestState.loading;
      coins = await _coinRepository.convertCoin(param);
      if (coins?.isNotEmpty == true) {
        _requestState = RequestState.success;
        notifyListeners();
        return coins;
      }
    } catch (e) {
      _requestState = RequestState.error;

      log('Error converting: $e', name: 'Controller.convertCoin()');
    }
    notifyListeners();
    return null;
  }

  Future<List<Map<String, dynamic>>> getAvailableCoins() async {
    try {
      _requestState = RequestState.loading;

      availablesCoin = await _coinRepository.getAvailableCoins();
      if (availablesCoin?.isNotEmpty == true) {
        _requestState = RequestState.success;
        notifyListeners();
        return availablesCoin ?? <Map<String, dynamic>>[];
      }
    } catch (e) {
      _requestState = RequestState.error;

      log('Error converting: $e', name: 'Controller.convertCoin()');
    }
    notifyListeners();
    return <Map<String, dynamic>>[];
  }
}
