import 'package:flutter/material.dart';
import 'about_us.dart';
import 'courses.dart';
import 'placement.dart';
import 'contact.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      
      drawer: Drawer(
        
        child: ListView(
          children: [
            DrawerHeader(
              
              child: Center(
                child: Image.asset(
                  'assets/Synnefo logo -01.png',
                  
                ),
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.info,
              title: 'About Us',
              page: AboutUsPage(),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.book,
              title: 'Courses',
              page: CoursesPage(),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.business_center,
              title: 'Placements',
              page: PlacementPage(),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.contact_mail,
              title: 'Contact Us',
              page: ContactUsPage(),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Synnefo logo -01.png'),
              const Text(
                'Choose a Portal',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              _buildButton(
                context,
                label: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
              const SizedBox(height: 20),
              _buildButton(
                context,
                label: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              const SizedBox(height: 20),
              _buildButton(
                context,
                label: 'Admin Login',
                onPressed: () {
                  Navigator.pushNamed(context, '/adminLogin');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 187, 0),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 5,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, {required IconData icon, required String title, required Widget page}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
