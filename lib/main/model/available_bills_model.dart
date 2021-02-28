class AvailableBills {
  Map<int, int> available = {};
  AvailableBills copyWith({Map<int, int> available}) => AvailableBills()..available = Map.from(available ?? this.available);
}

//['100', '200', '500', '1000', '2000', '5000']
