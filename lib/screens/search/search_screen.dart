import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'All';
  bool isSearching = false;

  final List<String> filters = [
    'All',
    'Properties',
    'Professionals',
    'Services',
  ];
  final List<String> recentSearches = [
    'Apartments in London',
    'Estate agents near me',
    'Property valuation',
    'Houses for rent',
    'Letting agents',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: Container(
          height: 40,
          child: TextField(
            controller: _searchController,
            autofocus: true,
            onChanged: (value) {
              setState(() {
                isSearching = value.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search properties, professionals...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() => isSearching = false);
                      },
                      icon: Icon(Icons.clear, color: Colors.grey[500]),
                    )
                  : null,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;
                return GestureDetector(
                  onTap: () => setState(() => selectedFilter = filter),
                  child: Container(
                    margin: EdgeInsets.only(right: 12, top: 8, bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF007AFF) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        filter,
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

          // Content
          Expanded(
            child: isSearching ? _buildSearchResults() : _buildDefaultContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (recentSearches.isNotEmpty) ...[
            Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            ...recentSearches.map((search) => _buildRecentSearchItem(search)),
            SizedBox(height: 24),
          ],

          // Popular Categories
          Text(
            'Popular Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildCategoryCard('Houses for Sale', Icons.home, Colors.blue),
              _buildCategoryCard(
                'Apartments to Rent',
                Icons.apartment,
                Colors.green,
              ),
              _buildCategoryCard('Estate Agents', Icons.people, Colors.orange),
              _buildCategoryCard(
                'Property Services',
                Icons.business_center,
                Colors.purple,
              ),
            ],
          ),

          SizedBox(height: 24),

          // Quick Filters
          Text(
            'Quick Filters',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Under £300k',
              'New Properties',
              'Luxury Homes',
              'Student Housing',
              'Commercial',
              'Land & Farms',
            ].map((filter) => _buildQuickFilter(filter)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Search Results Header
        Row(
          children: [
            Text(
              'Search Results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Spacer(),
            Text(
              '${_getResultCount()} results',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Mock search results
        ...List.generate(5, (index) => _buildSearchResultCard(index)),
      ],
    );
  }

  Widget _buildRecentSearchItem(String search) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(Icons.history, color: Colors.grey[500], size: 20),
        title: Text(
          search,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.north_west, color: Colors.grey[500], size: 18),
        ),
        onTap: () {
          _searchController.text = search;
          setState(() => isSearching = true);
        },
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
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

  Widget _buildQuickFilter(String filter) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          filter,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultCard(int index) {
    final List<Map<String, dynamic>> mockResults = [
      {
        'type': 'property',
        'title': 'Modern Apartment in Central London',
        'subtitle': '2 bed • 2 bath • £450,000',
        'location': 'Central London',
        'icon': Icons.home_work,
        'color': Colors.blue,
      },
      {
        'type': 'professional',
        'title': 'John Smith - Estate Agent',
        'subtitle': 'Premium Properties Ltd • 4.8★',
        'location': 'London',
        'icon': Icons.person,
        'color': Colors.green,
      },
      {
        'type': 'service',
        'title': 'Property Valuation Service',
        'subtitle': 'Professional valuation services',
        'location': 'Available nationwide',
        'icon': Icons.business_center,
        'color': Colors.orange,
      },
    ];

    final result = mockResults[index % mockResults.length];

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [result['color'].withOpacity(0.3), result['color']],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(result['icon'], color: Colors.white, size: 24),
        ),
        title: Text(
          result['title'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result['subtitle'],
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                SizedBox(width: 2),
                Text(
                  result['location'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: () {},
      ),
    );
  }

  int _getResultCount() {
    return _searchController.text.isNotEmpty ? 15 : 0;
  }
}
