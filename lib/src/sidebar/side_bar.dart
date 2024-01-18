import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import 'bloc/bloc.dart';
import 'widgets/widgets.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  late final SidebarBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<SidebarBloc>(context, listen: false);
  }

 @override
Widget build(BuildContext context) {
  return Container(
    color: Colors.white, // Set your desired background color here
    child: BlocBuilder<SidebarBloc, SidebarState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state.status == SidebarStatus.failure) {
          return const SizedBox(width: 200, child: Text("Error..."));
        }
        if (state.status == SidebarStatus.initial) {
          return const SizedBox(width: 200, child: Text("Loading..."));
        }

        List<LabReportAndPatient> displayList = state.showReportsInReview
            ? state.inReviewLabReports
            : state.deniedLabReports;

        return ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 250,
            maxWidth: 250,
          ),
          child: Column(
            children: [
              Toggles(state),
              const SizedBox(height: 20),
              if (displayList.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final e = displayList[index];
                      return SidebarItem(
                        onTap: () {
                          _bloc.add(
                              SelectReportEvent(index, displayList[index]));
                        },
                        isSelected: state.selectedIndex == index,
                        name: e.patient.name,
                        birthDate: e.patient.birthDate,
                        date: e.labReport.reportDate,
                      );
                    },
                  ),
                ),
              const UserCard(
                name: 'Dr. John Strasse', // Replace with actual name
                email: 'user@example.com', // Replace with actual email
                imageUrl: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D', // Replace with actual image URL
              ),
            ],
          ),
        );
      },
    )
  );
  }
}



class UserCard extends StatelessWidget {
  final String name;  // Name of the user
  final String email; // Email of the user
  final String imageUrl; // URL of the user's profile picture

  const UserCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.all(13),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), 
        side: const BorderSide(color: Color(0XFFE6E6E6), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items in Row
          children: [
            Row(
              mainAxisSize: MainAxisSize.min, // Group the avatar and text together
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 23, 
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      email,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.expand_more), // Add the expand_more icon
          ],
        ),
      ),
    );
  }
}


