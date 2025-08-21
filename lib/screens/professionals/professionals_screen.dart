// screens/professionals/professionals_screen.dart
import 'package:flutter/material.dart';

import '../search/search_screen.dart';

class ProfessionalsScreen extends StatefulWidget {
  @override
  _ProfessionalsScreenState createState() => _ProfessionalsScreenState();
}

class _ProfessionalsScreenState extends State<ProfessionalsScreen> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Estate Agents',
    'Letting Agents',
    'Property Managers',
    'Valuers',
    'Solicitors',
    'Mortgage Advisors',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Professionals',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list, color: Colors.black87),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            icon: Icon(Icons.search, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = category),
                  child: Container(
                    margin: EdgeInsets.only(right: 12, top: 8, bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF007AFF) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Professionals List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildProfessionalCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalCard(int index) {
    final List<Map<String, dynamic>> professionals = [
      {
        'name': 'John Smith',
        'role': 'Estate Agent',
        'company': 'Premium Properties Ltd',
        'rating': 4.8,
        'reviews': 156,
        'verified': true,
        'speciality': 'Luxury Properties',
        'location': 'Central London',
      },
      {
        'name': 'Sarah Johnson',
        'role': 'Letting Agent',
        'company': 'City Rentals',
        'rating': 4.9,
        'reviews': 203,
        'verified': true,
        'speciality': 'Student Housing',
        'location': 'South London',
      },
      {
        'name': 'Michael Brown',
        'role': 'Property Manager',
        'company': 'Brown & Associates',
        'rating': 4.7,
        'reviews': 89,
        'verified': false,
        'speciality': 'Commercial Properties',
        'location': 'West London',
      },
    ];

    final professional = professionals[index % professionals.length];

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Profile Image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[400]!, Colors.blue[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),

                SizedBox(width: 16),

                // Professional Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            professional['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          if (professional['verified']) ...[
                            SizedBox(width: 6),
                            Icon(Icons.verified, size: 18, color: Colors.blue),
                          ],
                        ],
                      ),

                      SizedBox(height: 4),

                      Text(
                        professional['role'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        professional['company'],
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                // Favorite Button
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border, color: Colors.grey[400]),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Rating and Location
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(
                  professional['rating'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '(${professional['reviews']} reviews)',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                SizedBox(width: 16),
                Icon(Icons.location_on, color: Colors.grey[500], size: 16),
                SizedBox(width: 4),
                Text(
                  professional['location'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Speciality Tag
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF007AFF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Speciality: ${professional['speciality']}',
                  style: TextStyle(
                    color: Color(0xFF007AFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.message, size: 16),
                    label: Text('Message'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xFF007AFF),
                      side: BorderSide(color: Color(0xFF007AFF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.phone, size: 16),
                    label: Text('Call'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF007AFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
