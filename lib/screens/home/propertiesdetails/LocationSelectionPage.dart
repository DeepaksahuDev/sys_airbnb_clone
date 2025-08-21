import 'package:flutter/material.dart';

class LocationSelectionPage extends StatefulWidget {
  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  List<String> locations = [
    "London, UK",
    "Paris, France",
    "Dubai, UAE",
    "Singapore",
    "New York, USA",
    "Mumbai, India",
  ];

  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                // refresh static data (you can later connect to API)
                locations.shuffle();
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return RadioListTile<String>(
            title: Text(locations[index]),
            value: locations[index],
            groupValue: selectedLocation,
            onChanged: (value) {
              setState(() {
                selectedLocation = value;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
          if (selectedLocation != null) {
            Navigator.pop(context, selectedLocation);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please select a location")),
            );
          }
        },
        label: const Text("Confirm"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
