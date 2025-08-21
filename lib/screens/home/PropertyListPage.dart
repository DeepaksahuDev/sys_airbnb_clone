import 'package:flutter/material.dart';
import 'package:sy_airbnb_clone/screens/home/propertiesdetails/PropertyDetailsPage.dart';

class PropertyListPage extends StatefulWidget {
  final String type;
  const PropertyListPage({required this.type, Key? key}) : super(key: key);

  @override
  State<PropertyListPage> createState() => _PropertyListPageState();
}

class _PropertyListPageState extends State<PropertyListPage> {
  List<Map<String, dynamic>> properties = [];
  String selectedLocation = 'All';

  final List<String> locations = ['All', 'London', 'Manchester', 'Liverpool'];

  @override
  void initState() {
    super.initState();
    _generateDummyProperties();
  }

  void _generateDummyProperties() {
    properties = List.generate(30, (index) {
      return {
        'title': '${widget.type} Property ${index + 1}',
        'location': locations[(index % locations.length)],
        'price': '£${(200 + index) * 1000}',
        'bedrooms': (1 + index % 5),
        'bathrooms': (1 + index % 3),
        'description':
            'This is a beautiful ${widget.type.toLowerCase()} located in ${locations[(index % locations.length)]}. Spacious rooms and modern amenities included.',
        'images': [
          'https://picsum.photos/id/${index + 10}/400/250', // Balcony
          'https://picsum.photos/id/${index + 20}/400/250', // Living room
          'https://picsum.photos/id/${index + 30}/400/250', // Bedroom
        ],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProperties = selectedLocation == 'All'
        ? properties
        : properties.where((p) => p['location'] == selectedLocation).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Properties'),
        backgroundColor: Color(0xFF007AFF),
      ),
      body: Column(
        children: [
          // Location filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: locations.map((loc) {
                final isSelected = loc == selectedLocation;
                return GestureDetector(
                  onTap: () => setState(() => selectedLocation = loc),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF007AFF) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        loc,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PropertyDetailsPage(
                          images: List<String>.from(property['images'] ?? []),
                          title: property['title'] ?? 'No Title',
                          location: property['location'] ?? 'Unknown',
                          price: property['price'] ?? '0',
                          bedrooms: property['bedrooms'] ?? 0,
                          bathrooms: property['bathrooms'] ?? 0,
                          sqft: property['sqft'] ?? 0,
                          description: property['description'] ?? '',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Image.network(
                        property['images'][0],
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      title: Text(property['title']),
                      subtitle: Text(
                        '${property['bedrooms']} bed • ${property['bathrooms']} bath • ${property['location']}',
                      ),
                      trailing: Text(
                        property['price'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF007AFF),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
