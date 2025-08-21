import 'package:flutter/material.dart';
import '../main_screen.dart';

class ContactAgentPage extends StatefulWidget {
  final String propertyTitle;
  final String propertyLocation;
  final String propertyPrice;
  final String propertyImage;

  const ContactAgentPage({
    super.key,
    required this.propertyTitle,
    required this.propertyLocation,
    required this.propertyPrice,
    required this.propertyImage,
  });

  @override
  State<ContactAgentPage> createState() => _ContactAgentPageState();
}

class _ContactAgentPageState extends State<ContactAgentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Date picker
  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    }
  }

  // Time picker
  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() => selectedTime = pickedTime);
    }
  }

  // Confirmation Dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("🎉 Booking Confirmed"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(widget.propertyImage, height: 150, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(
              widget.propertyTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.propertyLocation),
            const SizedBox(height: 10),
            if (selectedDate != null && selectedTime != null)
              Text(
                "Visit on: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year} at ${selectedTime!.format(context)}",
                style: const TextStyle(color: Colors.green),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (route) => false,
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (selectedDate == null || selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please pick date & time for visit")),
        );
        return;
      }
      _showConfirmationDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Agent"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Property Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.network(
                      widget.propertyImage,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      widget.propertyTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(widget.propertyLocation),
                    trailing: Text(
                      widget.propertyPrice,
                      style: const TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Your Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v!.isEmpty ? "Enter your name" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (v) => v!.isEmpty ? "Enter your phone" : null,
                  ),
                  const SizedBox(height: 20),

                  // Date & Time
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.calendar_today),
                          label: Text(
                            selectedDate == null
                                ? "Pick Date"
                                : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                          ),
                          onPressed: _pickDate,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.access_time),
                          label: Text(
                            selectedTime == null
                                ? "Pick Time"
                                : selectedTime!.format(context),
                          ),
                          onPressed: _pickTime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: _handleSubmit,
                    child: const Text(
                      "Buy Now & Schedule Visit",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
}
