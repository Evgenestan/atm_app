import 'package:atm_app/main/model/available_bills_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailableBillsWidget extends StatelessWidget {
  const AvailableBillsWidget({Key key, this.availableBills}) : super(key: key);

  final AvailableBills availableBills;

  List<Widget> _buildItems() {
    final available = availableBills.available;
    /*return Text(
      '${availableBills.available.values.elementAt(count)} X ${availableBills.available.keys.elementAt(count)} рублей',
      textAlign: TextAlign.center,
    );*/
    final widgets = <Widget>[];
    for (int item in available.keys) {
      widgets.add(Container(
        width: 150,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${available[item]} X $item рублей',
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      // child: GridView.builder(
      //   physics: NeverScrollableScrollPhysics(),
      //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100, mainAxisSpacing: 0),
      //   itemBuilder: _buildItem,
      //   padding: EdgeInsets.zero,
      //   itemCount: availableBills.available.length,
      // ),
      child: Wrap(
        children: _buildItems(),
      ),
    );
  }
}
