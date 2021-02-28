import 'dart:async';

import 'package:atm_app/main/model/available_bills_model.dart';
import 'package:atm_app/main/model/response_model.dart';

const defaultOptions = [5000, 2000, 1000, 500, 200, 100];
const defaultValues = [50, 100, 100, 5, 50, 40];

class MainBloc {
  MainBloc({AvailableBills availableBills}) {
    _availableBills = availableBills ?? AvailableBills()
      ..available = Map.fromIterables(defaultOptions, defaultValues);
    _outEvent.listen(_giveMoney);
    _inATMBalance.add(_availableBills);
  }

  AvailableBills _availableBills;

  final StreamController<Response> _responseController = StreamController<Response>();
  final StreamController<AvailableBills> _atmBalanceController = StreamController<AvailableBills>();
  final StreamController<double> _eventController = StreamController<double>();

  Sink<Response> get _inResponse => _responseController.sink;
  Stream<Response> get response => _responseController.stream;

  Sink<AvailableBills> get _inATMBalance => _atmBalanceController.sink;
  Stream<AvailableBills> get atmBalance => _atmBalanceController.stream;

  Sink<double> get giveOut => _eventController.sink;
  Stream<double> get _outEvent => _eventController.stream;

  void _giveMoney(double sum) {
    if (sum != null) {
      double _sum = sum;
      final Map<int, int> available = {};
      final AvailableBills _availableBillsLocal = _availableBills.copyWith();
      for (int item in _availableBillsLocal.available.keys) {
        int howMany = _sum ~/ item;
        if (howMany > 0) {
          if (howMany > _availableBillsLocal.available[item]) {
            howMany = _availableBillsLocal.available[item];
          }
          available[item] = howMany;
          _availableBillsLocal.available[item] -= howMany;
        }
        _sum -= howMany * item;
      }
      final availableBills = AvailableBills()..available = available;
      _inResponse.add(Response()
        ..availableBills = availableBills
        ..canGive = _sum == 0);
      if (_sum == 0) {
        _availableBills = _availableBillsLocal;
        _inATMBalance.add(_availableBills);
      }
    }
  }
}
