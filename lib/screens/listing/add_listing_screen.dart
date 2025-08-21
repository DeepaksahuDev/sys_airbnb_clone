import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  _AddListingScreenState createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  int currentStep = 0;
  String selectedPropertyType = '';
  String selectedListingType = 'Sale';
  bool hasBooster = false;
  String selectedBoosterPlan = 'Basic';
  int selectedBoosterDuration = 7;
  String selectedPriority = 'Normal';

  List<XFile> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  final List<String> propertyTypes = [
    'House',
    'Flat',
    'Bungalow/Villa',
    'Studio Flat',
    'Commercial Property',
    'Land/Farm',
    'Student Accommodation',
  ];

  final List<String> listingTypes = ['Sale', 'Rent'];
  final List<String> boosterPlans = ['Basic', 'Premium', 'Platinum'];
  final List<int> boosterDurations = [7, 14, 30];
  final List<String> priorities = ['Normal', 'URGENT', 'VERY URGENT'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'List Your Property',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.black87),
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isActive = index <= currentStep;
                final isCompleted = index < currentStep;

                return Row(
                  children: [
                    // Circle
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isActive ? Color(0xFF007AFF) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        isCompleted
                            ? Icons.check
                            : Icons.radio_button_unchecked,
                        color: isActive ? Colors.white : Colors.grey[600],
                        size: 16,
                      ),
                    ),

                    // Line after circle
                    if (index < 3)
                      Container(
                        width: 40, // Fixed width for spacing
                        height: 2,
                        color: index < currentStep
                            ? Color(0xFF007AFF)
                            : Colors.grey[300],
                      ),
                  ],
                );
              }),
            ),
          ),

          // Step Content
          Expanded(child: _buildStepContent()),

          // Navigation Buttons
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => currentStep--),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Back'),
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _canProceed() ? _handleNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF007AFF),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      currentStep == 3 ? 'List Property' : 'Next',
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
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildPropertyTypeStep();
      case 1:
        return _buildPropertyDetailsStep();
      case 2:
        return _buildBoosterStep();
      case 3:
        return _buildReviewStep();
      default:
        return Container();
    }
  }

  Widget _buildPropertyTypeStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Select Property Type',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'What type of property are you listing?',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 24),

          // Listing Type (Sale/Rent)
          Row(
            children: listingTypes.map((type) {
              final isSelected = selectedListingType == type;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedListingType = type),
                  child: Container(
                    margin: EdgeInsets.only(right: type == 'Sale' ? 8 : 0),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF007AFF) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Color(0xFF007AFF)
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'For $type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 24),

          // Property Types Grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: propertyTypes.length,
            itemBuilder: (context, index) {
              final type = propertyTypes[index];
              final isSelected = selectedPropertyType == type;
              return GestureDetector(
                onTap: () => setState(() => selectedPropertyType = type),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xFF007AFF).withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Color(0xFF007AFF) : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getPropertyIcon(type),
                        size: 32,
                        color: isSelected
                            ? Color(0xFF007AFF)
                            : Colors.grey[600],
                      ),
                      SizedBox(height: 8),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Color(0xFF007AFF)
                              : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyDetailsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Property Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tell us more about your property',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 24),

          // Property Title
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Property Title',
              hintText: 'e.g., Beautiful 2-bed apartment with garden',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF007AFF)),
              ),
            ),
          ),

          SizedBox(height: 16),

          // Price
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Price (£)',
              hintText: 'Enter property price',
              prefixText: '£ ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF007AFF)),
              ),
            ),
          ),

          SizedBox(height: 16),

          // Location
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Location',
              hintText: 'Enter property location',
              prefixIcon: Icon(Icons.location_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF007AFF)),
              ),
            ),
          ),

          SizedBox(height: 16),

          // Bedrooms and Bathrooms
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Bedrooms',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFF007AFF)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Bathrooms',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFF007AFF)),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Description
          TextFormField(
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Describe your property...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF007AFF)),
              ),
            ),
          ),

          SizedBox(height: 24),

          // Photo Upload
          GestureDetector(
            onTap: () async {
              final List<XFile>? images = await _picker.pickMultiImage(
                imageQuality: 80,
              );
              if (images != null) {
                setState(() {
                  selectedImages = images;
                });
              }
            },
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: selectedImages.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          size: 40,
                          color: Colors.grey[600],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Upload Photos & Videos',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Tap to add images',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.file(
                            File(selectedImages[index].path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoosterStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Boost Your Listing',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Get more visibility with our Campaign Booster',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 24),

          // Booster Toggle
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Campaign Booster',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Promote your listing for better visibility',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: hasBooster,
                  onChanged: (value) => setState(() => hasBooster = value),
                  activeColor: Color(0xFF007AFF),
                ),
              ],
            ),
          ),

          if (hasBooster) ...[
            SizedBox(height: 24),

            // Booster Plans
            Text(
              'Select Plan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),

            ...boosterPlans.map((plan) {
              final isSelected = selectedBoosterPlan == plan;
              final prices = {'Basic': 369, 'Premium': 379, 'Platinum': 599};
              return GestureDetector(
                onTap: () => setState(() => selectedBoosterPlan = plan),
                child: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xFF007AFF).withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Color(0xFF007AFF) : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: isSelected
                            ? Color(0xFF007AFF)
                            : Colors.grey[400],
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '£${prices[plan]} - Enhanced visibility',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            SizedBox(height: 24),

            // Duration Selection
            Text(
              'Boost Duration',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),

            Row(
              children: boosterDurations.map((duration) {
                final isSelected = selectedBoosterDuration == duration;
                return Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => selectedBoosterDuration = duration),
                    child: Container(
                      margin: EdgeInsets.only(right: duration != 30 ? 8 : 0),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFF007AFF) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Color(0xFF007AFF)
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$duration days',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 24),

            // Priority Selection
            Text(
              'Priority Level',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),

            ...priorities.map((priority) {
              final isSelected = selectedPriority == priority;
              Color priorityColor = priority == 'URGENT'
                  ? Colors.orange
                  : priority == 'VERY URGENT'
                  ? Colors.red
                  : Colors.grey;

              return GestureDetector(
                onTap: () => setState(() => selectedPriority = priority),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? priorityColor.withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? priorityColor : Colors.grey[300]!,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: isSelected ? priorityColor : Colors.grey[400],
                      ),
                      SizedBox(width: 12),
                      Text(
                        priority,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? priorityColor : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review & Publish',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Review your listing before publishing',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 24),

          // Listing Summary
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Listing Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                _buildSummaryRow('Property Type', selectedPropertyType),
                _buildSummaryRow('Listing Type', 'For $selectedListingType'),
                if (hasBooster) ...[
                  _buildSummaryRow('Booster Plan', selectedBoosterPlan),
                  _buildSummaryRow('Duration', '$selectedBoosterDuration days'),
                  _buildSummaryRow('Priority', selectedPriority),
                ],
              ],
            ),
          ),

          SizedBox(height: 24),

          // Terms & Conditions
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Important Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'By publishing this listing, you agree to our Terms & Conditions and Privacy Policy. Your listing will be reviewed and published within 24 hours.',
                        style: TextStyle(fontSize: 14, color: Colors.blue[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedPropertyType.isNotEmpty &&
            selectedListingType.isNotEmpty;
      case 1:
        return true; // In real app, validate form fields
      case 2:
        return true;
      case 3:
        return true;
      default:
        return false;
    }
  }

  void _handleNext() {
    if (currentStep < 3) {
      setState(() => currentStep++);
    } else {
      // Submit listing
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 16),
              Text(
                'Listing Submitted!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your property listing has been submitted successfully. It will be reviewed and published within 24 hours.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close listing screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Done', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  IconData _getPropertyIcon(String type) {
    switch (type) {
      case 'House':
        return Icons.home;
      case 'Flat':
        return Icons.apartment;
      case 'Bungalow/Villa':
        return Icons.villa;
      case 'Studio Flat':
        return Icons.business;
      case 'Commercial Property':
        return Icons.store;
      case 'Land/Farm':
        return Icons.landscape;
      case 'Student Accommodation':
        return Icons.school;
      default:
        return Icons.home_work;
    }
  }
}
