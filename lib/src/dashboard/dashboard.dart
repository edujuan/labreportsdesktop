import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../sidebar/bloc/bloc.dart';
import 'bloc/bloc.dart';
import 'widgets/widgets.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>
    with TickerProviderStateMixin {
  late final SidebarBloc _sidebarBloc;
  late final DashboardBloc _bloc;

  final TextEditingController _paragraphController = TextEditingController();
  final List<TextEditingController> _newBoxController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final FocusNode _paragraphFocus = FocusNode();
  final List<FocusNode> _newBoxFocus = [FocusNode(), FocusNode(), FocusNode()];
  bool showAll = true;

  @override
  void initState() {
    super.initState();

    _sidebarBloc = Provider.of<SidebarBloc>(context, listen: false);
    _bloc = Provider.of<DashboardBloc>(context, listen: false);
  }

  void _updateExecutiveSummaryController(
    String executiveSummary,
    List<String> recommendations,
  ) {
    _paragraphController.text = executiveSummary;
    for (int i = 0; i < recommendations.length; i++) {
      _newBoxController[i].text = recommendations[i];
    }
  }

  @override
  void dispose() {
    _paragraphController.dispose();
    _paragraphFocus.dispose();
    _newBoxController.forEach((element) {
      element.dispose();
    });
    _newBoxFocus.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarBloc, SidebarState>(
      bloc: _sidebarBloc,
      builder: (sidebarContext, sidebarState) {
        final selectedReport = sidebarState.selectedLabReport;

        if (selectedReport == null) {
          return const Scaffold(
            backgroundColor: Color(0xFFF1F4F8),
            body: SafeArea(
              child: Align(child: Text("Select a patient from the sidebar")),
            ),
          );
        }

        _updateExecutiveSummaryController(
          selectedReport.labReport.summary,
          selectedReport.labReport.recommendations,
        );

        return BlocBuilder<DashboardBloc, DashboardState>(
          bloc: _bloc,
          builder: (dashboardContext, dashboardState) {
            return LayoutBuilder(builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (maxWidth / 3).clamp(250, 450),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 250),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Header(report: selectedReport),
                              const SizedBox(height: 16),
                              PatientSection(
                                report: selectedReport.labReport,
                                patient: selectedReport.patient,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildParagraphBox(selectedReport),
                            const SizedBox(height: 16),
                            _buildRecommendationsBox(selectedReport),
                            const SizedBox(height: 16),
                            _buildBiomarkersList(selectedReport),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
          },
        );
      },
    );
  }

  Widget _buildBiomarkersList(LabReportAndPatient selectedReport) {
    var labandpatient = selectedReport;

    final biomarkers = groupBy(
            selectedReport.labReport.biomarkerValues.values.where((biom) =>
                showAll ||
                (biom.minValue != null && biom.minValue! > biom.value) ||
                (biom.maxValue != null && biom.maxValue! < biom.value)),
            (Biomarker b) => b.bucket)
        .entries
        .map(
          (bucket) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  bucket.key,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (final b in bucket.value) _buildBiomarkerRow(b),
            ],
          ),
        )
        .toList();

    return _buildSectionContainer(
      children: biomarkers,
    );
  }

  Widget _buildBiomarkerRow(Biomarker biomarker) {
    final minimumRange = biomarker.minValue;
    final maximumRange = biomarker.maxValue;
    final valuePosition = biomarker.value;
    final title = biomarker.name;
    final unit = biomarker.unit;

    const double rangeSize = 120;

    double greenContainerWidth = rangeSize * 0.75;
    double greenStart = (1 - (greenContainerWidth / rangeSize)) * rangeSize;
    double expansionRation = 1.1;

    Offset offsetValue = Offset(0, 0);
    double lineLeftPosition;
    Color lineColor = Colors.green;

    if (minimumRange != null && maximumRange != null) {
      // Both ranges are provided
      greenContainerWidth =
          greenContainerWidth; // Or any other width you desire
      offsetValue = Offset(0, 0);

      if (valuePosition > minimumRange && valuePosition <= maximumRange) {
        lineLeftPosition = rangeSize / 2 +
            (greenContainerWidth / (maximumRange - minimumRange)) *
                (valuePosition - (minimumRange + maximumRange) / 2);
      } else if (valuePosition < minimumRange) {
        lineLeftPosition =
            ((1 - (greenContainerWidth / rangeSize)) / 3) * rangeSize;
        lineColor = Colors.red;
      } else if (valuePosition > maximumRange) {
        lineLeftPosition =
            (1 - ((1 - (greenContainerWidth / rangeSize)) / 3)) * rangeSize;
        lineColor = Colors.red;
      } else {
        lineLeftPosition = rangeSize / 2; // Default initialization
        lineColor = Colors.green;
      }
    } else if (minimumRange != null) {
      // Only minimumRange is provided
      greenContainerWidth = greenContainerWidth * expansionRation;
      greenStart = (1 - (greenContainerWidth / rangeSize)) * rangeSize;
      // greenContainerAlignment = Alignment.centerRight;
      offsetValue = Offset(10, 0);

      if (valuePosition >= minimumRange && valuePosition < minimumRange * 1.8) {
        lineLeftPosition = greenStart +
            greenContainerWidth *
                ((valuePosition - minimumRange) / (minimumRange));
      } else if (valuePosition >= minimumRange * 1.8) {
        lineLeftPosition = rangeSize * 0.95;
        lineColor = Colors.red;
      } else {
        lineLeftPosition =
            ((1 - (greenContainerWidth / rangeSize)) / 2) * rangeSize;
      }
    } else if (maximumRange != null) {
      // Only maximumRange is provided
      greenContainerWidth = greenContainerWidth * expansionRation;
      offsetValue = Offset(-10, 0);

      if (valuePosition <= maximumRange) {
        lineLeftPosition = greenContainerWidth * (valuePosition / maximumRange);
      } else {
        lineColor = Colors.red;
        lineLeftPosition =
            (1 - ((1 - (greenContainerWidth / rangeSize)) / 2)) * rangeSize;
      }
    } else {
      // Neither range is provided
      greenContainerWidth =
          greenContainerWidth; // Default width when no ranges are given
      // greenContainerAlignment = Alignment.center;
      offsetValue = Offset(0, 0);
      lineLeftPosition = rangeSize / 2; // Center the line as a default position
    }

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: double.infinity,
        decoration: _sectionDecoration(),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 2),
          child: Row(
            children: [
              SizedBox(
                height: 100,
                child: VerticalDivider(
                  width: 24,
                  thickness: 4,
                  indent: 12,
                  endIndent: 12,
                  color: lineColor,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Text('$valuePosition $unit'),
              ),
              SizedBox(
                width: rangeSize,
                height: 40,
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: rangeSize,
                      height: 10,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 221, 221, 221),
                          borderRadius: BorderRadius.circular(10)),
                    ),

                    // Green range container
                    Transform.translate(
                      offset: offsetValue,
                      child: Container(
                        width: greenContainerWidth,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    // Black line indicator
                    Positioned(
                      left: lineLeftPosition,
                      top: -3,
                      child:
                          Container(width: 2, height: 16, color: Colors.black),
                    ),

                    // Conditionally add labels at the bottom
                    if (minimumRange != null)
                      Positioned(
                        left: 10, // Adjust as needed
                        top: 15,
                        bottom: 0,
                        child: Text(
                          '$minimumRange $unit',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    if (maximumRange != null)
                      Positioned(
                        right: 10, // Adjust as needed
                        top: 15,
                        bottom: 0,
                        child: Text(
                          '$maximumRange $unit',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _sectionDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
    );
  }

  void _updateSummary(LabReportAndPatient selectedReport, String value) {
    _bloc.add(EditReportEvent(selectedReport.labReport.id, summary: value));

    final report = Report(
      id: selectedReport.labReport.id,
      name: selectedReport.labReport.name,
      reportDate: selectedReport.labReport.reportDate,
      biomarkerValues: selectedReport.labReport.biomarkerValues,
      patientId: selectedReport.labReport.patientId,
      summary: value,
      recommendations: selectedReport.labReport.recommendations,
      doctorName: selectedReport.labReport.doctorName,
      displayed: selectedReport.labReport.displayed,
    );

    _sidebarBloc.add(
      UpdateSelectedReportEvent(
        LabReportAndPatient(labReport: report, patient: selectedReport.patient),
      ),
    );
  }

  Widget _buildParagraphBox(LabReportAndPatient selectedReport) {
    return GestureDetector(
      onTap: () => setState(() => _paragraphFocus.requestFocus()),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // Background color for the box
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              focusNode: _paragraphFocus,
              controller: _paragraphController,
              onSubmitted: (value) => _updateSummary(selectedReport, value),
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Tap to edit summary...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check, size: 20, color: Colors.grey),
                  onPressed: () {
                    _updateSummary(
                        selectedReport, _paragraphController.value.text);
                  },
                ),
              ),
              style: const TextStyle(fontSize: 16),
              cursorColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  void _updateRecommendations(
      LabReportAndPatient selectedReport, String value, int index) {
    List<String> newRecommendations = [];
    for (int i = 0; i < selectedReport.labReport.recommendations.length; i++) {
      if (i == index) {
        newRecommendations.add(value);
      } else {
        newRecommendations.add(selectedReport.labReport.recommendations[i]);
      }
    }
    _bloc.add(
      EditReportEvent(selectedReport.labReport.id,
          recommendation: newRecommendations),
    );

    final report = Report(
        id: selectedReport.labReport.id,
        name: selectedReport.labReport.name,
        reportDate: selectedReport.labReport.reportDate,
        biomarkerValues: selectedReport.labReport.biomarkerValues,
        patientId: selectedReport.labReport.patientId,
        summary: selectedReport.labReport.summary,
        recommendations: newRecommendations,
        doctorName: selectedReport.labReport.doctorName,
        displayed: selectedReport.labReport.displayed);
    _sidebarBloc.add(
      UpdateSelectedReportEvent(
        LabReportAndPatient(labReport: report, patient: selectedReport.patient),
      ),
    );
  }

  Widget _buildRecommendationsBox(LabReportAndPatient selectedReport) {
    return GestureDetector(
      //onTap: () => setState(() => _newBoxFocus.requestFocus()),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // Background color for the box
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  const Text('Recommendations',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                ] +
                selectedReport.labReport.recommendations.indexed
                    .map(
                      (indexedRecommendation) => TextField(
                        focusNode: _newBoxFocus[indexedRecommendation.$1],
                        controller: _newBoxController[indexedRecommendation.$1],
                        onSubmitted: (value) => _updateRecommendations(
                            selectedReport, value, indexedRecommendation.$1),
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tap to edit...',
                          suffixIcon: IconButton(
                            icon:
                                Icon(Icons.check, size: 20, color: Colors.grey),
                            onPressed: () {
                              _updateRecommendations(
                                  selectedReport,
                                  _newBoxController[indexedRecommendation.$1]
                                      .value
                                      .text,
                                  indexedRecommendation.$1);
                            },
                          ),
                        ),
                        style: TextStyle(fontSize: 16),
                        cursorColor: Colors.blue,
                      ),
                    )
                    .toList()),
      ),
    );
  }

  Widget _buildSectionContainer({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
          children: <Widget>[
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      tooltip: showAll ? "Show only out of range biomarkers" : "Show all",
                      onPressed: () {
                        setState(() {
                          showAll = !showAll;
                        });
                      },
                      icon: const Icon(Icons.filter_list_alt),
                    )),
              ] +
              children),
    );
  }

  // Method to group biomarkers by their bucket.
  Map<K, List<T>> groupBy<T, K>(Iterable<T> values, K Function(T) keyFunction) {
    var map = <K, List<T>>{};
    for (var element in values) {
      var key = keyFunction(element);
      if (!map.containsKey(key)) {
        map[key] = [];
      }
      map[key]!.add(element);
    }
    return map;
  }
}
