class CalcController {
  //Convert number to Money format
  String? toMoneyFormat(String value) {
    int c = 0;
    String end = '';
    int index = value.length;

    if (value.contains('.')) {
      index = value.lastIndexOf('.');
      //Take the part after dot if available
      end = value.substring(index);
    }
    //Put each number into a list and respective dot ( . )
    List auxMoney = [];
    for (int i = index - 1; i >= 0; i--) {
      if (c < 3) {
        auxMoney.add(value[i]);
        c++;
      } else {
        auxMoney.add('.');
        auxMoney.add(value[i]);
        c = 1;
      }
    }
    //Join all numbers again
    value = '';
    for (int i = auxMoney.length - 1; i >= 0; i--) {
      value += auxMoney[i];
    }

    if (end.length <= 3) {
      end = end.replaceFirst('.', ',');
    }
    return '$value$end';
  }
}
