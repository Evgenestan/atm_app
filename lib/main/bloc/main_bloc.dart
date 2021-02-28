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
  }

  AvailableBills _availableBills;

  final StreamController<Response> _responseController = StreamController<Response>();
  final StreamController<double> _eventController = StreamController<double>();

  Sink<Response> get _inCounter => _responseController.sink;
  Stream<Response> get response => _responseController.stream;

  Sink<double> get giveOut => _eventController.sink;
  Stream<double> get _outEvent => _eventController.stream;

  void _giveMoney(double sum) {
    if (sum != null) {
      double _sum = sum;
      final Map<int, int> available = {};
      for (int item in _availableBills.available.keys) {
        final howMany = _sum ~/ item;
        if (howMany > 0) {
          available[item] = howMany;
        }
        _sum -= howMany * item;
      }
      final availableBills = AvailableBills()..available = available;
      _inCounter.add(Response()
        ..availableBills = availableBills
        ..canGive = _sum == 0);
    }
  }
}
