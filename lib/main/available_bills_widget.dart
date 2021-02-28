import 'package:atm_app/colors.dart';
import 'package:atm_app/main/model/available_bills_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailableBillsWidget extends StatelessWidget {
  const AvailableBillsWidget({Key key, this.availableBills}) : super(key: key);

  final AvailableBills availableBills;

  List<Widget> _buildItems() {
    final available = availableBills.available;
    final widgets = <Widget>[];
    for (int item in available.keys) {
      if (available[item] != 0) {
        widgets.add(
          Container(
            width: 150,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${available[item]} X $item рублей',
              style: const TextStyle(color: startGradientColor, fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 13,
        horizontal: 20,
      ),
      child: Wrap(
        children: _buildItems(),
      ),
    );
  }
}
