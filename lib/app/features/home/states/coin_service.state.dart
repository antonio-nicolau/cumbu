import 'package:cumbu/app/core/controller/coin.service.dart';
import 'package:cumbu/app/core/repository/coin.repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getAvailablesCoinsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return CoinService(CoinRepository()).getAvailableCoins();
});

final dataTransferStateProvider = StateProvider<DataTransfer?>((ref) {
  return DataTransfer();
});

class DataTransfer {
  Map<String, dynamic>? toCoin;
  Map<String, dynamic>? fromCoin;

  DataTransfer({this.toCoin, this.fromCoin});

  DataTransfer copyWith({Map<String, dynamic>? toCoin, Map<String, dynamic>? fromCoin}) {
    return DataTransfer(
      toCoin: toCoin ?? this.toCoin,
      fromCoin: fromCoin ?? this.fromCoin,
    );
  }
}
