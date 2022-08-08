import 'package:cumbu/app/features/ad_manager.dart';
import 'package:cumbu/app/core/controller/coin.service.dart';
import 'package:cumbu/app/core/model/coin.model.dart';
import 'package:cumbu/app/core/model/coin.param.dart';
import 'package:cumbu/app/core/repository/coin.repository.dart';
import 'package:cumbu/app/features/home/states/coin_service.state.dart';
import 'package:cumbu/app/features/home/widgets/ad_container.dart';
import 'package:cumbu/app/features/home/widgets/my_bank_selected.dart';
import 'package:cumbu/app/features/home/widgets/progress_bar.dart';
import 'package:cumbu/app/features/home/widgets/refresh_page.dart';
import 'package:cumbu/app/features/home/widgets/my_drowdown_button.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final coinService = CoinService(CoinRepository());
  BannerAd? firstBannerAd, secondBannerAd;
  AdWidget? adWidget1, adWidget2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toCoin = ref.watch(dataTransferStateProvider.select((value) => value?.toCoin));
    final fromCoin = ref.watch(dataTransferStateProvider.select((value) => value?.fromCoin));
    final coin = useState<Coin?>(null);
    final availablesCoinState = ref.watch(getAvailablesCoinsProvider);
    final amoutEditingController = useTextEditingController(text: "1");

    useEffect(
      () {
        firstBannerAd = AdManager().createBannerAd();
        secondBannerAd = AdManager().createBannerAd();
        firstBannerAd?.load();
        secondBannerAd?.load();

        if (firstBannerAd != null || secondBannerAd != null) {
          adWidget1 = AdWidget(ad: firstBannerAd!);
          adWidget2 = AdWidget(ad: secondBannerAd!);
        }
        return;
      },
      [],
    );

    Future<void> convertCoin() async {
      if (amoutEditingController.text.isNotEmpty) {
        final amount = amoutEditingController.text.trim();

        final param = CoinQueryParam(
          amountToConvert: amount,
          originCoinCode: fromCoin?['codigoMoeda'],
          destinCoinCode: toCoin?['codigoMoeda'],
        );
        final response = await coinService.convertCoin(param);
        if (response?.isNotEmpty == true) {
          // NOTE: Take the Sell values
          coin.value = response?.first;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.monetization_on),
        centerTitle: false,
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.monetization_on, size: 120.0, color: Colors.amber),
            availablesCoinState.when(
              data: (availablesCoin) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  if (toCoin == null || fromCoin == null) {
                    ref.read(dataTransferStateProvider.state).state = DataTransfer(
                      toCoin: availablesCoin.firstWhere(
                        (e) => e['codigoMoeda'] == 'EUR',
                        orElse: () => availablesCoin.first,
                      ),
                      fromCoin: availablesCoin.firstWhere(
                        (e) => e['codigoMoeda'] == 'AOA',
                        orElse: () => availablesCoin[1],
                      ),
                    );
                  }
                });

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyDropdownButton(
                      items: availablesCoin,
                      dropdownValue: fromCoin,
                      onChange: (data) {
                        ref.read(dataTransferStateProvider.state).state = ref.read(dataTransferStateProvider)?.copyWith(fromCoin: data);
                      },
                    ),
                    const SizedBox(height: 15.0),
                    TextField(
                      controller: amoutEditingController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '€ ',
                        labelText: 'Montante',
                        labelStyle: TextStyle(color: Colors.amber),
                        prefixStyle: TextStyle(color: Colors.amber),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber, width: 1.0)),
                      ),
                      style: const TextStyle(color: Colors.amber, fontSize: 22.0),
                    ),
                    const SizedBox(height: 15.0),
                    MyDropdownButton(
                      items: availablesCoin,
                      dropdownValue: toCoin,
                      onChange: (data) {
                        ref.read(dataTransferStateProvider.state).state = ref.read(dataTransferStateProvider)?.copyWith(toCoin: data);
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                          padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
                      onPressed: convertCoin,
                      child: Text(
                        'Converter',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    exchangeResultWidget(context, coin.value),
                    const SizedBox(height: 15),
                    containerAd(adWidget1, firstBannerAd),
                    const SizedBox(height: 15),
                    containerAd(adWidget2, secondBannerAd),
                  ],
                );
              },
              error: (err, _) => refreshPage(() => coinService.getAvailableCoins()),
              loading: () => progressBar(),
            ),
          ],
        ),
      ),
    );
  }
}
