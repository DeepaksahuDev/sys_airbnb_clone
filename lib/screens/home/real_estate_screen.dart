import 'package:flutter/material.dart';
import 'package:sy_airbnb_clone/screens/home/propertiesdetails/LocationSelectionPage.dart';
import 'package:sy_airbnb_clone/screens/home/propertiesdetails/PropertyDetailsPage.dart';
import '../Notifications/NotificationsScreen.dart';
import '../search/search_screen.dart';
import '../listing/add_listing_screen.dart';
import 'PropertyListPage.dart';

class RealEstateScreen extends StatefulWidget {
  const RealEstateScreen({super.key});

  @override
  _RealEstateScreenState createState() => _RealEstateScreenState();
}

class _RealEstateScreenState extends State<RealEstateScreen> {
  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Top Header with Search
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final selectedLocation = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationSelectionPage(),
                            ),
                          );
                          if (selectedLocation != null) {
                            setState(() {
                              _selectedLocation =
                                  selectedLocation; // store in variable
                            });
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Color(0xFF007AFF),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _selectedLocation ??
                                  'London, UK', // default London, UK
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationsScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.notifications_outlined),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Search Bar
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey[600]),
                          SizedBox(width: 12),
                          Text(
                            'Search properties, locations...',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Quick Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQuickActionButton(
                        icon: Icons.home,
                        label: 'Buy',
                        color: Color(0xFF007AFF),
                        onTap: () => _showPropertyCategory('buy'),
                      ),
                      _buildQuickActionButton(
                        icon: Icons.sell,
                        label: 'Sell',
                        color: Colors.green,
                        onTap: () => _showPropertyCategory('sell'),
                      ),
                      _buildQuickActionButton(
                        icon: Icons.key,
                        label: 'Rent',
                        color: Colors.orange,
                        onTap: () => _showPropertyCategory('rent'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured Properties Section
                    _buildSectionHeader('Featured Properties', () {}),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return _buildFeaturedPropertyCard(index);
                        },
                      ),
                    ),

                    SizedBox(height: 24),

                    // Property Types Section
                    _buildSectionHeader('Property Types', () {}),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: propertyTypes.length,
                        itemBuilder: (context, index) {
                          return _buildPropertyTypeCard(propertyTypes[index]);
                        },
                      ),
                    ),

                    SizedBox(height: 24),

                    // New Buildings Section
                    _buildSectionHeader('New Buildings', () {}),
                    SizedBox(height: 12),
                    Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return _buildNewBuildingCard(
                            context,
                            index,
                          ); // ✅ context भी pass करो
                        },
                      ),
                    ),

                    SizedBox(height: 24),

                    // Recent Listings
                    _buildSectionHeader('Recent Listings', () {}),
                    SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return _buildRecentListingCard(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button for Add Listing
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddListingScreen()),
          );
        },
        backgroundColor: Color(0xFF007AFF),
        icon: Icon(Icons.add, color: Colors.white),
        label: Text('List Property', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 30),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
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
          onTap: onViewAll,
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

  final List<String> propertyImages = [
    "https://images.unsplash.com/photo-1507089947368-19c1da9775ae", // Modern luxury apartment
    "https://images.unsplash.com/photo-1560185127-6ed189bf02f4", // Bright living room flat
    "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267", // Flat with swimming pool
    "https://images.unsplash.com/photo-1505691938895-1758d7feb511", // Luxury villa with pool
    "https://images.unsplash.com/photo-1600585154340-be6161a56a0c", // Apartment interior with pool view
  ];

  Widget _buildFeaturedPropertyCard(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertyDetailsPage(
              images: propertyImages, // List<String> images
              title: "Modern Apartment ${index + 1}",
              location: "London, UK",
              price: "£${(450000 + index * 5000).toString()}", // example price
              bedrooms: 3, // example value
              bathrooms: 2, // example value
              sqft: 1250, // example value
              description:
                  "This is a modern apartment with spacious rooms, balcony, and all amenities included.",
            ),
          ),
        );
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // ✅ Background Image
              SizedBox(
                height: 220,
                width: double.infinity,
                child: Image.network(
                  propertyImages[index % propertyImages.length],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey,
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),

              // ✅ Gradient overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modern Apartment ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'London, UK',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '£${(450000 + index * 50000).toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ✅ Featured label
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'FEATURED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
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

  // Property Type Card
  Widget _buildPropertyTypeCard(Map<String, dynamic> propertyType) {
    return GestureDetector(
      onTap: () {
        // Navigate to PropertyListPage with type
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertyListPage(type: propertyType['name']),
          ),
        );
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(propertyType['icon'], size: 32, color: Color(0xFF007AFF)),
            SizedBox(height: 8),
            Text(
              propertyType['name'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Property Card Builder
  Widget _buildNewBuildingCard(BuildContext context, int index) {
    final List<Map<String, String>> properties = [
      {
        "imageUrl":
            "https://images.unsplash.com/photo-1507089947368-19c1da9775ae",
        "title": "Modern Luxury Apartment",
        "location": "London, UK",
        "price": "\$250,000",
      },
      {
        "imageUrl": "https://images.unsplash.com/photo-1560185127-6ed189bf02f4",
        "title": "Bright Living Room Flat",
        "location": "Paris, France",
        "price": "\$180,000",
      },
      {
        "imageUrl":
            "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267",
        "title": "Flat with Swimming Pool",
        "location": "Dubai, UAE",
        "price": "\$320,000",
      },
      {
        "imageUrl":
            "https://images.unsplash.com/photo-1505691938895-1758d7feb511",
        "title": "Luxury Villa with Pool",
        "location": "Miami, USA",
        "price": "\$450,000",
      },
      {
        "imageUrl":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        "title": "Apartment Interior Pool View",
        "location": "Singapore",
        "price": "\$300,000",
      },
    ];

    final property = properties[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertyDetailsPage(
              images: propertyImages, // List<String> images
              title: "Modern Apartment ${index + 1}",
              location: "London, UK",
              price: "£${(450000 + index * 5000).toString()}", // example price
              bedrooms: 3, // example value
              bathrooms: 2, // example value
              sqft: 1250, // example value
              description:
                  "This is a modern apartment with spacious rooms, balcony, and all amenities included.",
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  property["imageUrl"]!,
                  height: 87,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property["title"]!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      property["location"]!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildRecentListingCard(int index) {
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
              gradient: LinearGradient(
                colors: [Colors.purple[300]!, Colors.purple[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            ),
            child: Icon(Icons.home, size: 40, color: Colors.white),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Property Listing ${index + 1}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Central London',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '£${(300000 + index * 100000).toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF007AFF),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPropertyCategory(String category) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property Types - ${category.toUpperCase()}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: propertyTypes.map((type) {
                  return _buildPropertyTypeCard(type);
                }).toList(),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  final List<Map<String, dynamic>> propertyTypes = [
    {'name': 'Houses', 'icon': Icons.home},
    {'name': 'Flats', 'icon': Icons.apartment},
    {'name': 'Villas', 'icon': Icons.villa},
    {'name': 'Studio', 'icon': Icons.business},
    {'name': 'Commercial', 'icon': Icons.store},
    {'name': 'Land', 'icon': Icons.landscape},
    {'name': 'Overseas', 'icon': Icons.public},
    {'name': 'Student', 'icon': Icons.school},
    {'name': 'Retirement', 'icon': Icons.elderly},
  ];
}
