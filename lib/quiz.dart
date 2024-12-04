import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/Authenticate/login.dart'; // Replace with your LoginPage import
import 'subjectquiz.dart'; // Replace with your SubjectQuizPage import

class QuizPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   QuizPage({super.key});

  Future<void> logout(BuildContext context) async {
    try {
      // Perform Firebase logout
      await FirebaseAuth.instance.signOut();

      // Navigate to LoginPage and clear the navigation stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your LoginPage
        (route) => false, // Remove all previous routes
      );
    } catch (e) {
      print("Error during Firebase sign-out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to logout: $e')),
      );
    }
  }

  Future<void> showLogoutConfirmation(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Cancel logout
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(context, true), // Confirm logout
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    // Proceed with logout if confirmed
    if (shouldLogout == true) {
      logout(context);
    }
  }

  final List<Course> courses = [
    Course(title: "MERN", imagePath: "assets/mern.jpg"),
    Course(title: "UI/UX", imagePath: "assets/ui.jpg"),
    Course(title: "Flutter", imagePath: "assets/flutter.jpg"),
    Course(title: "DevOps", imagePath: "assets/devops.jpg"),
    Course(title: "Cyber Security", imagePath: "assets/cyber.jpg"),
    Course(title: "Network Engineering", imagePath: "assets/NE.jpg"),
    Course(title: "Digital Marketing", imagePath: "assets/digital_m.jpg"),
    Course(title: "PHP", imagePath: "assets/php1.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Available Quizzes"),
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => showLogoutConfirmation(context), // Show confirmation dialog
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8, // Adjust card height vs width
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return _buildCourseCard(course, context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(Course course, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectQuizPage(subject: course.title), // Navigate to subject quiz
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  course.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.book, size: 50, color: Colors.grey);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                course.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.yellow,
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

class Course {
  final String title;
  final String imagePath;

  Course({required this.title, required this.imagePath});
}
