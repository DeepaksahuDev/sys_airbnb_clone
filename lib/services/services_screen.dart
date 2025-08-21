// screens/services/services_screen.dart
import 'package:flutter/material.dart';

import '../screens/search/search_screen.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Services',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            icon: Icon(Icons.search, color: Colors.black87),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Real Estate Services Section
            _buildSectionHeader('Real Estate Services'),
            SizedBox(height: 12),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: realEstateServices.length,
                itemBuilder: (context, index) {
                  return _buildServiceCard(realEstateServices[index]);
                },
              ),
            ),

            SizedBox(height: 24),

            // Consultancy Services Section
            _buildSectionHeader('Consultancy Services'),
            SizedBox(height: 12),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: consultancyServices.length,
                itemBuilder: (context, index) {
                  return _buildServiceCard(consultancyServices[index]);
                },
              ),
            ),

            SizedBox(height: 24),

            // Business Services Section
            _buildSectionHeader('Business Services'),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: businessServices.length,
                itemBuilder: (context, index) {
                  return _buildServiceCard(businessServices[index]);
                },
              ),
            ),

            SizedBox(height: 24),

            // Featured Services Grid
            _buildSectionHeader('Featured Services'),
            SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: featuredServices.length,
              itemBuilder: (context, index) {
                return _buildFeaturedServiceCard(featuredServices[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'View All',
            style: TextStyle(
              color: Color(0xFF007AFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  service['image'] ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: service['colors'],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          service['icon'],
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: service['colors'],
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
            Padding(
              padding: EdgeInsets.all(16),
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
                  SizedBox(height: 4),
                  Text(
                    service['description'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: service['colors'][0].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      service['category'],
                      style: TextStyle(
                        fontSize: 10,
                        color: service['colors'][0],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedServiceCard(Map<String, dynamic> service) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  service['image'] ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: service['colors'],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          service['icon'],
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: service['colors'],
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
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    service['name'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> realEstateServices = [
    {
      'name': 'Property Valuation',
      'description': 'Professional property valuation services',
      'category': 'Valuation',
      'icon': Icons.assessment,
      'colors': [Colors.blue[400]!, Colors.blue[600]!],
      'image':
          'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Property Management',
      'description': 'Complete property management solutions',
      'category': 'Management',
      'icon': Icons.manage_accounts,
      'colors': [Colors.green[400]!, Colors.green[600]!],
      'image':
          'https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Legal Services',
      'description': 'Property legal and conveyancing services',
      'category': 'Legal',
      'icon': Icons.gavel,
      'colors': [Colors.orange[400]!, Colors.orange[600]!],
      'image':
          'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Mortgage Advisory',
      'description': 'Expert mortgage and finance advice',
      'category': 'Finance',
      'icon': Icons.account_balance,
      'colors': [Colors.purple[400]!, Colors.purple[600]!],
      'image':
          'https://images.unsplash.com/photo-1554224155-6726b3ff858f?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
  ];

  final List<Map<String, dynamic>> consultancyServices = [
    {
      'name': 'Investment Advisory',
      'description': 'Property investment consultation',
      'category': 'Investment',
      'icon': Icons.trending_up,
      'colors': [Colors.teal[400]!, Colors.teal[600]!],
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Market Analysis',
      'description': 'Property market research and analysis',
      'category': 'Analysis',
      'icon': Icons.analytics,
      'colors': [Colors.indigo[400]!, Colors.indigo[600]!],
      'image':
          'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Development Planning',
      'description': 'Property development planning services',
      'category': 'Planning',
      'icon': Icons.engineering,
      'colors': [Colors.brown[400]!, Colors.brown[600]!],
      'image':
          'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Tax Advisory',
      'description': 'Property tax consultation services',
      'category': 'Tax',
      'icon': Icons.calculate,
      'colors': [Colors.red[400]!, Colors.red[600]!],
      'image':
          'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
  ];

  final List<Map<String, dynamic>> businessServices = [
    {
      'name': 'Business Setup',
      'description': 'Company formation and setup services',
      'category': 'Setup',
      'icon': Icons.business,
      'colors': [Colors.cyan[400]!, Colors.cyan[600]!],
      'image':
          'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Franchise Opportunities',
      'description': 'Real estate franchise opportunities',
      'category': 'Franchise',
      'icon': Icons.store,
      'colors': [Colors.pink[400]!, Colors.pink[600]!],
      'image':
          'https://images.unsplash.com/photo-1497366216548-37526070297c?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Partnership Services',
      'description': 'Business partnership and collaboration',
      'category': 'Partnership',
      'icon': Icons.handshake,
      'colors': [Colors.amber[400]!, Colors.amber[600]!],
      'image':
          'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Marketing Solutions',
      'description': 'Property marketing and advertising',
      'category': 'Marketing',
      'icon': Icons.campaign,
      'colors': [Colors.deepOrange[400]!, Colors.deepOrange[600]!],
      'image':
          'https://images.unsplash.com/photo-1556761175-b413da4baf72?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
  ];

  final List<Map<String, dynamic>> featuredServices = [
    {
      'name': 'Premium Listing',
      'description': 'Featured property listings',
      'icon': Icons.star,
      'colors': [Colors.yellow[600]!, Colors.orange[600]!],
      'image':
          'https://images.unsplash.com/photo-1560520653-9e0e4c89eb11?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': '24/7 Support',
      'description': 'Round the clock customer support',
      'icon': Icons.support_agent,
      'colors': [Colors.blue[600]!, Colors.purple[600]!],
      'image':
          'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Virtual Tours',
      'description': 'Professional virtual property tours',
      'icon': Icons.view_in_ar,
      'colors': [Colors.green[600]!, Colors.teal[600]!],
      'image':
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
    {
      'name': 'Document Verification',
      'description': 'Property document verification',
      'icon': Icons.verified_user,
      'colors': [Colors.red[600]!, Colors.pink[600]!],
      'image':
          'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
    },
  ];
}
