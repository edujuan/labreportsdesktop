import 'package:json_annotation/json_annotation.dart';

part 'biomarker.g.dart';

@JsonSerializable()
class Biomarker {
  final String id;
  final String name;
  final String bucket;
  final double value;
  final double? minValue;
  final double? maxValue;
  final String unit;
  final String biomarkerDescription;
  final String rangeDescription;

  const Biomarker({
  required this.id,
  required this.name,
  required this.bucket,
  required this.value,
  required this.minValue,
  required this.maxValue,
  required this.unit,
  required this.biomarkerDescription,
  required this.rangeDescription,
  });

  String getHealth() {
    // Special case for Glucose
    if (name == 'Glucose') {
      if (value > maxValue! && value <= 125) {
        return "Pre-diabetes";
      } else if (value >= 126) {
        return "Diabetes";
      }
    }

    // Special cases for Vitamins
    if (name == 'Vitamin D' || name == 'Vitamin B12') {
      double tolerance = name == 'Vitamin D' ? 0.10 : 0.20;
      if (minValue != null && value < minValue! * (1 - tolerance)) {
        return "Slightly Low";
      } else if (maxValue != null && value > maxValue! * (1 + tolerance)) {
        return "Slightly High";
      }
    }

    // Only min or only max
    if (minValue == null && maxValue != null) {
      return value <= (maxValue ?? double.infinity) ? "Healthy" : "High";
    } else if (maxValue == null && minValue != null) {
      return value >= (minValue ?? double.negativeInfinity) ? "Healthy" : "Low";
    }

    // General case
    if (minValue != null && maxValue != null) {
      if (value >= minValue! && value <= maxValue!) {
        return "Healthy";
      } else if (value > maxValue!) {
        return "High";
      } else {
        return "Low";
      }
    }

    return "Data not available"; // In case min and max are both null
  }



  factory Biomarker.fromJson(Map<String, dynamic> json) =>
      _$BiomarkerFromJson(json);

  Map<String, dynamic> toJson() => _$BiomarkerToJson(this);
}
