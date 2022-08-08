import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyDropdownButton extends HookConsumerWidget {
  const MyDropdownButton({
    Key? key,
    required this.items,
    required this.onChange,
    required this.dropdownValue,
  }) : super(key: key);

  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>) onChange;
  final Map<String, dynamic>? dropdownValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<Map<String, dynamic>>(
      value: dropdownValue,
      icon: const Icon(Icons.monetization_on),
      dropdownColor: Colors.black,
      items: items
          .map(
            (e) => DropdownMenuItem<Map<String, dynamic>>(
              value: e,
              child: Text(
                e['designacaoMoeda'],
                style: const TextStyle(color: Colors.amber),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          onChange.call(value);
        }
      },
    );
  }
}
