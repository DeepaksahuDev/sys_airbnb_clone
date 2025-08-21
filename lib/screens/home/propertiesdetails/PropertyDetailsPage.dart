import 'package:flutter/material.dart';
import 'contactagent.dart';

List<Map<String, String>> wishlist = [];

class PropertyDetailsPage extends StatefulWidget {
  final List<String> images; // Multiple images
  final String title;
  final String location;
  final String price;
  final int bedrooms;
  final int bathrooms;
  final int sqft;
  final String description;

  const PropertyDetailsPage({
    super.key,
    required this.images,
    required this.title,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.sqft,
    required this.description,
  });

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  bool isWishlisted = false;
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Property Details"),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isWishlisted = !isWishlisted;
              });

              if (isWishlisted) {
                wishlist.add({
                  "title": widget.title,
                  "location": widget.location,
                  "price": widget.price,
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Wishlist")),
                );
              } else {
                wishlist.removeWhere((item) => item["title"] == widget.title);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Removed from Wishlist")),
                );
              }
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // 🔹 Image slider
          SizedBox(
            height: 250,
            child: PageView.builder(
              onPageChanged: (index) => setState(() => currentImage = index),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.images[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentImage == index ? 12 : 8,
                height: currentImage == index ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentImage == index ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),

          // 🔹 Details Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.location,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const Divider(height: 30),

                  // 🔹 Extra Property Info
                  const Text(
                    "Property Info",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _InfoTile(
                        icon: Icons.king_bed,
                        label: "${widget.bedrooms} Bedrooms",
                      ),
                      _InfoTile(
                        icon: Icons.bathtub,
                        label: "${widget.bathrooms} Bathrooms",
                      ),
                      _InfoTile(
                        icon: Icons.square_foot,
                        label: "${widget.sqft} sqft",
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),

      // 🔹 Contact Agent + Buy Now Buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactAgentPage(
                        propertyTitle: widget.title,
                        propertyLocation: widget.location,
                        propertyPrice: widget.price,
                        propertyImage: widget.images[0],
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Contact Agent",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactAgentPage(
                        propertyTitle: widget.title,
                        propertyLocation: widget.location,
                        propertyPrice: widget.price,
                        propertyImage: widget.images[0],
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Buy Now",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Small reusable widget for info row
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.red, size: 28),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
