import 'package:flutter/material.dart';

// Model for placement details
class Placementpage {
  final String name;
  final String designation;
  final String company;
  final String imageUrl;

  Placementpage({
    required this.name,
    required this.designation,
    required this.company,
    required this.imageUrl,
  });
}

// Placement Page Widget
class PlacementPage extends StatelessWidget {
  final List<Placementpage> profiles = [
    Placementpage(
      name: "Krishnajith",
      designation: "Cisco Certified Network Associate",
      company: "Company A",
      imageUrl: "assets/img3.jpeg", // Local image
    ),
    Placementpage(
      name: "Alan Thomas",
      designation: "Digital Marketing",
      company: "Story Sphere",
      imageUrl: "assets/img4.jpeg", // Local image
    ),
    Placementpage(
      name: "Anfal Ahad",
      designation: "Digital Marketing",
      company: "Company B",
      imageUrl: "assets/img5.jpeg", // Local image
    ),
    Placementpage(
      name: "Noel John Varghese",
      designation: "Digital Marketing",
      company: "Company C",
      imageUrl: "assets/img6.jpeg", // Local image
    ),
    Placementpage(
      name: "Anjitha Nair",
      designation: "Python and Django Full Stack Web Developer",
      company: "Company D",
      imageUrl: "assets/img7.jpeg", // Local image
    ),
    Placementpage(
      name: "Amal",
      designation: "Digital Marketing",
      company: "Company E",
      imageUrl: "assets/img8.jpeg", // Local image
    ),
  ];

   PlacementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Placement Page"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two cards in each row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            final profile = profiles[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      profile.imageUrl, // Local image
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Name
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  // Designation
                  Text(
                    profile.designation,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  // Company Name
                  Text(
                    profile.company.isNotEmpty
                        ? "Placed in ${profile.company}"
                        : "Not Assigned",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PlacementPage(),
  ));
}
