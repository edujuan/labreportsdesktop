import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/models.dart';

class ApiClient {
  ApiClient({
    required String baseUrl,
    required http.Client httpClient,
  })  : _httpClient = httpClient,
        _baseUrl = baseUrl;

  final String _baseUrl;
  final http.Client _httpClient;

  Future<List<LabReportAndPatient>> getReportsInReview() async {
    try {
      final response = await _request('/lab-reports/in-review/');
      var reports = (response["list"] as List<dynamic>)
          .map((reportJson) => LabReportAndPatient.fromJson(reportJson))
          .toList();
      return reports;
    } catch (e) {
      print(e);
      List<LabReportAndPatient> dummyData = [];
      // Mock data initialization
      for (int i = 0; i < 4; i++) {
        var labReport = Report(
          id: 'lab-report-id-$i',
          name: 'Blood test $i',
          reportDate: DateTime.now(),
          // Assuming you have a Map<String, Biomarker> for biomarkerValues
          biomarkerValues: <String, Biomarker>{
            "Test 1": const Biomarker(
                id: "",
                name: "Test 1",
                bucket: "Bucket 1",
                value: 2,
                minValue: 1,
                maxValue: 3,
                unit: "unit",
                biomarkerDescription: "Description",
                rangeDescription: "Range Desc"),
            "Test 2": const Biomarker(
                id: "",
                name: "Test 2",
                bucket: "Bucket 1",
                value: 2,
                minValue: 1,
                maxValue: 3,
                unit: "unit",
                biomarkerDescription: "Description",
                rangeDescription: "Range Desc"),
            "Test 3": const Biomarker(
                id: "",
                name: "Test 3",
                bucket: "Bucket 2",
                value: 2,
                minValue: 1,
                maxValue: 3,
                unit: "unit",
                biomarkerDescription: "Description",
                rangeDescription: "Range Desc")
          },
          // Replace with actual biomarker values
          patientId: 'patient-id-$i',
          executiveSummary: "Executive summary of lab report $i",
          recommendations: "Recommendations based on lab report $i",
          doctorName: "Dr. Smith $i",
          displayed: false,
        );

        var patientHistory = PatientHistory(
          text: "Patient $i has a history of...",
          weight: 70 + i,
          height: 175 + i,
        );

        var patient = Patient(
          name: "John Doe $i",
          phoneNumber: '+491111',
          history: patientHistory,
          birthDate: DateTime(1985, 5, 20).add(Duration(days: i * 365)),
          id: '',
        );
        dummyData
            .add(LabReportAndPatient(labReport: labReport, patient: patient));
      }
      return dummyData;
    }
  }

  Future<List<LabReportAndPatient>> getDeniedReports() async {
    try {
      final response = await _request('/lab-reports/denied/');
      var reports = (response["list"] as List<dynamic>)
          .map((reportJson) => LabReportAndPatient.fromJson(reportJson))
          .toList();
      return reports;
    } catch (e) {
      print(e);
      List<LabReportAndPatient> dummyData = [];
      // Mock data initialization
      for (int i = 4; i < 8; i++) {
        var labReport = Report(
          id: 'lab-report-id-$i',
          name: 'Blood test $i',
          reportDate: DateTime.now(),
          // Assuming you have a Map<String, Biomarker> for biomarkerValues
          biomarkerValues: <String, Biomarker>{
            "Test 1": const Biomarker(
                id: "",
                name: "Test 1",
                bucket: "Bucket 1",
                value: 2,
                minValue: 1,
                maxValue: 3,
                unit: "unit",
                biomarkerDescription: "Description",
                rangeDescription: "Range Desc"),
            "Test 2": const Biomarker(
                id: "",
                name: "Test 2",
                bucket: "Bucket 1",
                value: 2,
                minValue: 1,
                maxValue: 3,
                unit: "unit",
                biomarkerDescription: "Description",
                rangeDescription: "Range Desc"),
            "Test 3": const Biomarker(
                id: "",
                name: "Test 3",
                bucket: "Bucket 2",
                value: 2,
                minValue: 1,
                maxValue: 3,
                unit: "unit",
                biomarkerDescription: "Description",
                rangeDescription: "Range Desc")
          },
          // Replace with actual biomarker values
          patientId: 'patient-id-$i',
          executiveSummary: "Executive summary of lab report $i",
          recommendations: "Recommendations based on lab report $i",
          doctorName: "Dr. Smith $i",
          displayed: false,
        );

        var patientHistory = PatientHistory(
          text: "Patient $i has a history of...",
          weight: 70 + i,
          height: 175 + i,
        );

        var patient = Patient(
          name: "John Doe $i",
          history: patientHistory,
          phoneNumber: '+491111',
          birthDate: DateTime(1985, 5, 20).add(Duration(days: i * 365)),
          id: '',
        );
        dummyData
            .add(LabReportAndPatient(labReport: labReport, patient: patient));
      }
      return dummyData;
    }
  }

  Future<Report?> editReport(
      String id, String? summary, String? recommendation) async {
    final response = await _request('/lab-reports/edit/$id',
        body: ReportEdit(
                executiveSummary: summary, recommendations: recommendation)
            .toJson());
    return Report.fromJson(response);
  }

  Future<void> approve(String id) async {
    await _request('/lab-reports/approve/$id', shouldBePost: true);
  }

  Future<void> deny(String id, bool patientShouldSchedule) async {
    await _request('/lab-reports/deny/$id',
        queryParams: {"patientShouldSchedule": "$patientShouldSchedule"},
        shouldBePost: true);
  }
}

/// HTTP request logic
extension ApiClientX on ApiClient {
  Future<Map<String, dynamic>> _request(String endpoint,
      {Map<String, String>? queryParams,
      Map<String, dynamic>? body,
      bool shouldBePost = false}) async {
    Uri uri = _constructUrl(endpoint, queryParams: queryParams);

    http.Response response;

    try {
      if (body == null && !shouldBePost) {
        response = await _httpClient.get(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
        );
      } else {
        response = await _httpClient.post(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(body),
        );
        print(response);
      }

      if (response.statusCode != 200) {
        throw HttpRequestFailure(response.statusCode);
      }
    } on Exception {
      throw HttpException();
    }

    return _parseResponse(response);
  }

  Uri _constructUrl(
    String endpoint, {
    Map<String, String>? queryParams,
  }) {
    Uri uri;

    if (queryParams != null) {
      uri = Uri.http(_baseUrl, endpoint, queryParams);
    } else {
      uri = Uri.http(_baseUrl, endpoint);
    }
    return uri;
  }

  Map<String, dynamic> _parseResponse(http.Response response) {
    Map<String, dynamic> body;

    try {
      var decoded = json.decode(response.body);
      if (decoded is Map) {
        body = decoded as Map<String, dynamic>;
      } else {
        body = {"list": decoded as List<dynamic>};
      }
    } on Exception {
      throw JsonDecodeException();
    }

    return body;
  }
}

/// Thrown if an exception occurs while making an `http` request.
class HttpException implements Exception {}

/// {@template http_request_failure}
/// Thrown if an `http` request returns a non-200 status code.
/// {@endtemplate}
class HttpRequestFailure implements Exception {
  /// {@macro http_request_failure}
  const HttpRequestFailure(this.statusCode);

  /// The status code of the response.
  final int statusCode;
}

/// Thrown if an excepton occurs while decoding the response body.
class JsonDecodeException implements Exception {}

/// Thrown is an error occurs while deserializing the response body.
class JsonDeserializationException implements Exception {}
