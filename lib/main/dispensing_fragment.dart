import 'package:atm_app/colors.dart';
import 'package:atm_app/main/available_bills_widget.dart';
import 'package:atm_app/main/bloc/main_bloc.dart';
import 'package:atm_app/main/model/response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DispensingFragment extends StatelessWidget {
  Widget _buildWidget(Response response) {
    if (response == null) {
      return const SizedBox();
    }
    if (response.canGive) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Банкомат выдал следующие купюры',
              style: TextStyle(color: secondTextColor),
            ),
          ),
          AvailableBillsWidget(availableBills: response?.availableBills),
          const Divider(thickness: 10, color: dividerColor),
        ],
      );
    }
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Text(
            'Банкомат не может выдать, запрашиваемую сумму',
            style: TextStyle(color: buttonColor, fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        Divider(thickness: 10, color: dividerColor),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _mainBloc = Provider.of<MainBloc>(context, listen: false);
    return StreamBuilder<Response>(
      builder: (_, response) => Container(
        child: _buildWidget(response.data),
      ),
      stream: _mainBloc.response,
    );
  }
}
