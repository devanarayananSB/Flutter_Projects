import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  final List<Course> courses = [
    Course(
        title: "MERN Stack",
        imagePath: "assets/mern.jpg"),
    Course(
        title: "UI/UX",
        imagePath: "assets/ui.jpg"),
    Course(
        title: "Mobile Application Development: Flutter",
        imagePath: "assets/flutter.jpg"),
    Course(
        title: "Master In DevOps",
        imagePath: "assets/devops.jpg"),
    Course(
        title: "Advanced Diploma In Cyber Security",
        imagePath: "assets/cyber.jpg"),
    Course(
        title: "Advanced Diploma In Network Engineering: Cloud & Security",
        imagePath: "assets/NE.jpg"),
    Course(
        title: "Advanced Diploma In Digital Marketing: AI Integrated",
        imagePath: "assets/digital_m.jpg"),
    Course(
        title: "Full Stack Web Development: PHP",
        imagePath: "assets/php1.jpg"),
  ];

   CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
        backgroundColor: const Color.fromARGB(255, 255, 187, 0),
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
            return _buildCourseCard(course);
          },
        ),
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return Card(
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
                  color: Color.fromARGB(255, 255, 187, 0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Course {
  final String title;
  final String imagePath;

  Course({required this.title, required this.imagePath});
}
