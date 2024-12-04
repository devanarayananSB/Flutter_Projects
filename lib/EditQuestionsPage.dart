import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/EditSubjectQuestionsPage.dart';

class EditQuestionsPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   EditQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Questions'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('quizzes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching subjects'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No subjects available'));
          }

          final subjects = snapshot.data!.docs;

          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              final subjectName = subject.id;

              return ListTile(
                title: Text(
                  subjectName,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditSubjectQuestionsPage(
                        subject: subjectName,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
