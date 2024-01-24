import 'package:json_annotation/json_annotation.dart';

part 'report_edit.g.dart';

@JsonSerializable()
class ReportEdit {
  final String? summary;
  final List<String>? recommendations;

  const ReportEdit({
    this.summary,
    this.recommendations,
  });

  factory ReportEdit.fromJson(Map<String, dynamic> json) =>
      _$ReportEditFromJson(json);

  Map<String, dynamic> toJson() => _$ReportEditToJson(this);
}
