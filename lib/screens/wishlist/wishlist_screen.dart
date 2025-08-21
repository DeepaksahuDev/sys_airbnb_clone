import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../services/auth_service.dart';
import '../auth/login_screen.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final AuthService _auth = AuthService();
  String selectedTab = 'Properties';

  final List<String> tabs = ['Properties', 'Professionals', 'Services'];

  @override
  Widget build(BuildContext context) {
    // Check if user is logged in
    if (_auth.currentUser == null) {
      return _buildNotLoggedInView();
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Wishlist',
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
            onPressed: () {
              Share.share(
                'Check out this amazing app: https://play.google.com/store/apps/details?id=com.example.myapp',
                subject: 'Amazing Real Estate App',
              );
            },
            icon: Icon(Icons.share, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              children: tabs.map((tab) {
                final isSelected = selectedTab == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = tab),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected
                                ? Color(0xFF007AFF)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tab,
                          style: TextStyle(
                            color: isSelected
                                ? Color(0xFF007AFF)
                                : Colors.grey[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Content
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  Widget _buildNotLoggedInView() {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
              SizedBox(height: 24),
              Text(
                'Sign in to view your wishlist',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Save your favorite properties, professionals, and services to access them anytime',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF007AFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 'Properties':
        return _buildPropertiesTab();
      case 'Professionals':
        return _buildProfessionalsTab();
      case 'Services':
        return _buildServicesTab();
      default:
        return _buildPropertiesTab();
    }
  }

  Widget _buildPropertiesTab() {
    // Mock data for saved properties with network images
    final List<Map<String, dynamic>> savedProperties = [
      {
        'title': 'Modern Apartment',
        'location': 'Central London',
        'price': '£450,000',
        'bedrooms': 2,
        'bathrooms': 2,
        'type': 'Apartment',
        'image':
            'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      },
      {
        'title': 'Victorian House',
        'location': 'South London',
        'price': '£750,000',
        'bedrooms': 4,
        'bathrooms': 3,
        'type': 'House',
        'image':
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      },
      {
        'title': 'Studio Flat',
        'location': 'East London',
        'price': '£320,000',
        'bedrooms': 1,
        'bathrooms': 1,
        'type': 'Studio',
        'image':
            'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      },
    ];

    if (savedProperties.isEmpty) {
      return _buildEmptyState(
        icon: Icons.home_work,
        title: 'No saved properties',
        subtitle: 'Properties you like will appear here',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: savedProperties.length,
      itemBuilder: (context, index) {
        final property = savedProperties[index];
        return _buildPropertyCard(property);
      },
    );
  }

  Widget _buildProfessionalsTab() {
    final List<Map<String, dynamic>> savedProfessionals = [
      {
        'name': 'John Smith',
        'role': 'Estate Agent',
        'company': 'Premium Properties Ltd',
        'rating': 4.8,
        'verified': true,
      },
      {
        'name': 'Sarah Johnson',
        'role': 'Letting Agent',
        'company': 'City Rentals',
        'rating': 4.9,
        'verified': true,
      },
    ];

    if (savedProfessionals.isEmpty) {
      return _buildEmptyState(
        icon: Icons.people,
        title: 'No saved professionals',
        subtitle: 'Professionals you like will appear here',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: savedProfessionals.length,
      itemBuilder: (context, index) {
        final professional = savedProfessionals[index];
        return _buildProfessionalCard(professional);
      },
    );
  }

  Widget _buildServicesTab() {
    final List<Map<String, dynamic>> savedServices = [
      {
        'name': 'Property Valuation',
        'provider': 'Expert Valuers Ltd',
        'category': 'Valuation',
        'rating': 4.7,
      },
    ];

    if (savedServices.isEmpty) {
      return _buildEmptyState(
        icon: Icons.business_center,
        title: 'No saved services',
        subtitle: 'Services you like will appear here',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: savedServices.length,
      itemBuilder: (context, index) {
        final service = savedServices[index];
        return _buildServiceCard(service);
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey[400]),
            SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Text(
              subtitle,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> property) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.network(
                property['image'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[300]!, Colors.blue[600]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Icon(Icons.home_work, size: 40, color: Colors.white),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[300]!, Colors.blue[600]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite, color: Colors.red, size: 20),
                      ),
                    ],
                  ),
                  Text(
                    property['location'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    property['price'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007AFF),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${property['bedrooms']} bed • ${property['bathrooms']} bath',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalCard(Map<String, dynamic> professional) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[400]!, Colors.green[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(Icons.person, size: 25, color: Colors.white),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      professional['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (professional['verified']) ...[
                      SizedBox(width: 4),
                      Icon(Icons.verified, size: 16, color: Colors.blue),
                    ],
                  ],
                ),
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite, color: Colors.red, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[400]!, Colors.orange[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(Icons.business_center, size: 25, color: Colors.white),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  service['provider'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    service['category'],
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite, color: Colors.red, size: 20),
          ),
        ],
      ),
    );
  }
}
