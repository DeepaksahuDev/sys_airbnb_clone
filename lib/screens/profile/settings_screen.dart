// screens/profile/settings_screen.dart
import 'package:flutter/material.dart';

import 'editprofile.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedCurrency = 'GBP (£)';
  String selectedCountry = 'United Kingdom';
  String selectedLanguage = 'English';
  String selectedTheme = 'System Default';
  bool notificationsEnabled = true;
  bool emailNotifications = true;
  bool pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Settings',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),

            // Personal Information
            _buildSettingsSection('Personal Information', [
              _buildSettingsItem(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                subtitle: 'Update your personal details',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditProfileScreen()),
                  );
                },
              ),

              _buildSettingsItem(
                icon: Icons.security,
                title: 'Login Security',
                subtitle: 'Password and security settings',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy',
                subtitle: 'Manage your privacy settings',
                onTap: () {},
              ),
            ]),

            SizedBox(height: 16),

            // App Preferences
            _buildSettingsSection('App Preferences', [
              _buildDropdownItem(
                icon: Icons.currency_pound,
                title: 'Currency',
                value: selectedCurrency,
                options: ['GBP (£)', 'USD (\$)', 'EUR (€)'],
                onChanged: (value) => setState(() => selectedCurrency = value!),
              ),
              _buildDropdownItem(
                icon: Icons.public,
                title: 'Country',
                value: selectedCountry,
                options: [
                  'United Kingdom',
                  'United States',
                  'Germany',
                  'France',
                ],
                onChanged: (value) => setState(() => selectedCountry = value!),
              ),
              _buildDropdownItem(
                icon: Icons.language,
                title: 'Language',
                value: selectedLanguage,
                options: ['English', 'Spanish', 'French', 'German'],
                onChanged: (value) => setState(() => selectedLanguage = value!),
              ),
              _buildDropdownItem(
                icon: Icons.palette_outlined,
                title: 'Display Appearance',
                value: selectedTheme,
                options: ['Light Mode', 'Dark Mode', 'System Default'],
                onChanged: (value) => setState(() => selectedTheme = value!),
              ),
            ]),

            SizedBox(height: 16),

            // Notifications
            _buildSettingsSection('Notifications', [
              _buildSwitchItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Enable app notifications',
                value: notificationsEnabled,
                onChanged: (value) =>
                    setState(() => notificationsEnabled = value),
              ),
              _buildSwitchItem(
                icon: Icons.email_outlined,
                title: 'Email Notifications',
                subtitle: 'Receive updates via email',
                value: emailNotifications,
                onChanged: (value) =>
                    setState(() => emailNotifications = value),
              ),
              _buildSwitchItem(
                icon: Icons.mobile_friendly,
                title: 'Push Notifications',
                subtitle: 'Get push notifications',
                value: pushNotifications,
                onChanged: (value) => setState(() => pushNotifications = value),
              ),
            ]),

            SizedBox(height: 16),

            // Account
            _buildSettingsSection('Account', [
              _buildSettingsItem(
                icon: Icons.payment,
                title: 'Payment Methods',
                subtitle: 'Manage payment options',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.translate,
                title: 'Translation',
                subtitle: 'Auto-translate listings',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.accessibility,
                title: 'Accessibility',
                subtitle: 'Accessibility settings',
                onTap: () {},
              ),
            ]),

            SizedBox(height: 16),

            // Legal & Support
            _buildSettingsSection('Legal & Support', [
              _buildSettingsItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get help and contact support',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                subtitle: 'Read our terms of service',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'Learn about our privacy practices',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App version and information',
                onTap: () {},
              ),
            ]),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  item,
                  if (index < items.length - 1) Divider(height: 1, indent: 72),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF007AFF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Color(0xFF007AFF), size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF007AFF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Color(0xFF007AFF), size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: () {
        _showOptionsDialog(title, value, options, onChanged);
      },
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF007AFF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Color(0xFF007AFF), size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Color(0xFF007AFF),
      ),
    );
  }

  void _showOptionsDialog(
    String title,
    String currentValue,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select $title'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              final isSelected = option == currentValue;
              return ListTile(
                leading: Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected ? Color(0xFF007AFF) : Colors.grey[400],
                ),
                title: Text(
                  option,
                  style: TextStyle(
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: isSelected ? Color(0xFF007AFF) : Colors.black87,
                  ),
                ),
                onTap: () {
                  onChanged(option);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
          ],
        );
      },
    );
  }
}
