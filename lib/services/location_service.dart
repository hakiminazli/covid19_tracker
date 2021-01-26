import 'package:geolocator/geolocator.dart';

class LocationService {
  List<Position> _positions = [];
  List<Position> get positions => _positions;

  void add(Position position) {
    _positions.add(position);
  }
}
