import 'package:atm_app/main/bloc/main_bloc.dart';
import 'package:atm_app/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputFragment extends StatelessWidget {
  const InputFragment(this.sumController);
  final TextEditingController sumController;

  @override
  Widget build(BuildContext context) {
    final _mainBloc = Provider.of<MainBloc>(context, listen: false);

    void _giveOut() {
      _mainBloc.giveOut.add(double.tryParse(sumController.text));
    }

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
}
