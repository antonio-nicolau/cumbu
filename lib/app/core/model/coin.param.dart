class CoinQueryParam {
  final String amountToConvert;
  final String originCoinCode;
  final String destinCoinCode;

  CoinQueryParam({
    required this.amountToConvert,
    required this.originCoinCode,
    required this.destinCoinCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'moedaOrigem': originCoinCode,
      'moedaDestino': destinCoinCode,
      'montante': amountToConvert,
    };
  }
}
