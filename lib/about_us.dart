import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: const Color.fromARGB(255, 255, 187, 0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Synnefo Smart Space",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Synnefo SmartSpace is a fully flexible, ultra user-friendly solution that will erase your office pain points, reduce your building costs, and empower your people.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildFeatureCard(
                icon: Icons.code,
                title: "Open Source Software",
                description:
                    "As a group of FOSS enthusiasts, we ensure the tools we are implementing are 100% open source. No secret code to steal your data.",
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                icon: Icons.security,
                title: "Assured Security",
                description:
                    "As everything we implement is Open Source, we have nothing to hide. Community-driven software ensures quick fixes and security.",
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                icon: Icons.support_agent,
                title: "24 X 7 Support",
                description:
                    "We ensure the tools we implement are backed with 24/7 support to address all your needs.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: const Color.fromARGB(255, 255, 187, 0)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
