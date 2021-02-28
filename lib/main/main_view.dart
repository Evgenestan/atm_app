import 'package:atm_app/colors.dart';
import 'package:atm_app/main/available_bills_widget.dart';
import 'package:atm_app/main/bloc/main_bloc.dart';
import 'package:atm_app/main/dispensing_fragment.dart';
import 'package:atm_app/main/input_fragment.dart';
import 'package:atm_app/main/model/available_bills_model.dart';
import 'package:atm_app/widgets/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yalo_assets/lib.dart';

class MainView extends StatelessWidget {
  final sumController = TextEditingController();

  Widget _buildBalance(Stream atmBalance) {
    return StreamBuilder<AvailableBills>(
        stream: atmBalance,
        builder: (context, snapshot) {
          if (snapshot?.data == null) {
            return const SizedBox();
          }
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Баланс банкомата',
                  style: TextStyle(color: secondTextColor),
                ),
              ),
              AvailableBillsWidget(availableBills: snapshot?.data),
            ],
          );
        });
  }

  Widget _buildBody(BuildContext context) {
    final _mainBloc = Provider.of<MainBloc>(context, listen: false);
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 30),
      children: [
        InputFragment(sumController),
        const Divider(thickness: 10, color: dividerColor),
        DispensingFragment(),
        _buildBalance(_mainBloc.atmBalance),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [SvgPicture.asset(Assets.logoImageS), const SizedBox(width: 5), const Text('ATM')],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: <Color>[startGradientColor, endGradientColor])),
        ),
      ),
      body: Body(child: _buildBody(context)),
    );
  }
}
