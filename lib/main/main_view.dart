import 'package:atm_app/colors.dart';
import 'package:atm_app/main/bloc/main_bloc.dart';
import 'package:atm_app/widgets/body.dart';
import 'package:atm_app/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  final MainBloc mainBloc = MainBloc();
  final sumController = TextEditingController();
  void _giveOut() {
    mainBloc.giveOut.add(double.tryParse(sumController.text));
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

  Widget _buildBody() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 30),
      children: [
        _buildFirstBlock(),
        const Divider(thickness: 10, color: dividerColor),
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
