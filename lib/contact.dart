import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              const Text(
                "Get in Touch",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "We’d love to hear from you! Fill out the form below or connect with us via other channels.",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Name Field
              TextField(
                decoration: InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Email Field
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Subject Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Subject",
                  prefixIcon: const Icon(Icons.topic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: [
                  "General Inquiry",
                  "Support Request",
                  "Feedback",
                  "Other"
                ].map((subject) {
                  return DropdownMenuItem(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),

              // Message Field
              TextField(
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: "Your Message",
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.message),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton.icon(
                onPressed: () {
                  // Submit logic here
                },
                icon: const Icon(Icons.send),
                label: const Text("Send Message"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.orange,
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),

              // Additional Contact Options
              const Divider(height: 30, color: Colors.grey),
              const Text(
                "Other Ways to Reach Us",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Contact Details Row
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Email
                  ContactOption(
                    icon: Icons.email_outlined,
                    title: "Email",
                    description: "info@company.com",
                    color: Colors.blue,
                  ),
                  // Phone
                  ContactOption(
                    icon: Icons.phone_outlined,
                    title: "Phone",
                    description: "+1 234 567 890",
                    color: Colors.green,
                  ),
                  // Location
                  ContactOption(
                    icon: Icons.location_on_outlined,
                    title: "Location",
                    description: "123 Business Street",
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Social Media Row
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Contact Option Widget
class ContactOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const ContactOption({super.key, 
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: color),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Social Media Icon Widget
class SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const SocialMediaIcon({super.key, 
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: 36,
      color: color,
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ContactUsPage(),
  ));
}
