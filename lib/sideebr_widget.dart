import 'package:flutter/material.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({Key? key}) : super(key: key);

  @override
  _SidebarWidgetState createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      labelType: NavigationRailLabelType.all,
      destinations: [
        // NavigationRailDestination(
        //   icon: Icon(Icons.search),
        //   label: Text('Search'),
        // ),
        buildNavigationDestination("Müller, Thomas", "07.12.2023", "All Healthy", 0),
        buildNavigationDestination("Neuer, Manuel", "07.12.2023", "All Healthy", 1),
        buildNavigationDestination("Kimmich, Joshua", "08.12.2023", "All Healthy", 2),
        // Add more destinations here as needed
      ],
    );
  }

  NavigationRailDestination buildNavigationDestination(String name, String date, String results, int index) {
    bool isSelected = _selectedIndex == index;

    return NavigationRailDestination(
      icon:  
      Card(
        color: isSelected ? Colors.black : Colors.white,
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
      Icon(Icons.person_outline, color: isSelected ? Colors.white : Colors.black),
             
              SizedBox(width: 8), // Space between icon and text
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: $name', style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                  Text('Date: $date', style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                  Text('Results: $results', style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                ],
              ),
            ],
          ),
        ),
      ),
      
      
      label: const SizedBox()
    );
  }
}
