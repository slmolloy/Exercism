import "dart:math" as math;

class SpaceAge {
  double age({required String planet, required int seconds}) =>
      ((seconds / _orbitRatios[planet.toLowerCase()]!) / EARTH_YEAR_IN_SECONDS).roundToDecimal(2);

  final EARTH_YEAR_IN_SECONDS = 31557600;
  final Map<String, double> _orbitRatios = {
    'earth': 1.0,
    'mercury': 0.2408467,
    'venus': 0.61519726,
    'mars': 1.8808158,
    'jupiter': 11.862615,
    'saturn': 29.447498,
    'uranus': 84.016846,
    'neptune': 164.79132,
  };
}

extension on double {
  double roundToDecimal(int decimal) => (this * math.pow(10, decimal)).roundToDouble() / math.pow(10, decimal);
}
