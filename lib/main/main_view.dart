import 'package:atm_app/colors.dart';
import 'package:atm_app/main/available_bills_widget.dart';
import 'package:atm_app/main/bloc/main_bloc.dart';
import 'package:atm_app/main/model/available_bills_model.dart';
import 'package:atm_app/main/model/response_model.dart';
import 'package:atm_app/widgets/body.dart';
import 'package:atm_app/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MainView extends StatelessWidget {
  final MainBloc _mainBloc = MainBloc();
  final sumController = TextEditingController();
  void _giveOut() {
    _mainBloc.giveOut.add(double.tryParse(sumController.text));
  }

  Widget _buildFirstBlock() {
    return Center(
      child: Column(
        children: [
          const Text(
            'Введите сумму',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Container(
            width: 200,
            child: TextFormField(
              controller: sumController,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            width: 200,
            height: 60,
            child: MyButton(
              title: 'Выдать сумму',
              onPressed: _giveOut,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSecondBlock() {
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

    return StreamBuilder<Response>(
      builder: (_, response) => Container(
        child: _buildWidget(response.data),
      ),
      stream: _mainBloc.response,
    );
  }

  Widget _buildThirdBlock() {
    return StreamBuilder<AvailableBills>(
        stream: _mainBloc.atmBalance,
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
                  'Банкомат выдал следующие купюры',
                  style: TextStyle(color: secondTextColor),
                ),
              ),
              AvailableBillsWidget(availableBills: snapshot?.data),
              const Divider(thickness: 10, color: dividerColor),
            ],
          );
        });
  }

  Widget _buildBody() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 30),
      children: [
        _buildFirstBlock(),
        const Divider(thickness: 10, color: dividerColor),
        _buildSecondBlock(),
        _buildThirdBlock(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [Icon(Icons.calculate), Text('ATM')],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: <Color>[startGradientColor, endGradientColor])),
        ),
      ),
      body: Body(child: _buildBody()),
    );
  }
}
