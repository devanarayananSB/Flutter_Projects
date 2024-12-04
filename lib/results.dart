import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultsPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Results',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 251, 0),
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('results').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching results'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No results available',
                style: TextStyle(color: Colors.yellow, fontSize: 18),
              ),
            );
          }

          final results = snapshot.data!.docs;

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              final data = result.data() as Map<String, dynamic>?;

              if (data == null) {
                return const SizedBox.shrink(); // Skip invalid data
              }

              // Extracting fields
              final email = data['email'] ?? 'Email not available';
              final subject = data['subject'] ?? 'Unknown Subject';
              final submittedAt = data['submittedAt']?.toDate();
              final studentResults = data['results'] ?? [];

              // Calculate total marks
              final totalMarks = (studentResults as List).fold<int>(
                0,
                (sum, res) => sum + ((res['isCorrect'] ?? false) ? 5 : 0),
              );

              return Card(
                color: Colors.grey[850],
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subject: $subject',
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Student Email: $email',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total Marks: $totalMarks',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Submitted At: ${submittedAt != null ? submittedAt.toLocal().toString() : "N/A"}',
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Details:',
                        style: TextStyle(color: Colors.yellow, fontSize: 16),
                      ),
                      ...studentResults.map<Widget>((res) {
                        return ListTile(
                          title: Text(
                            res['question'] ?? 'Unknown Question',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'Your Answer: ${res['userAnswer'] ?? "N/A"} | Correct Answer: ${res['correctAnswer'] ?? "N/A"}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Icon(
                            (res['isCorrect'] ?? false) ? Icons.check : Icons.close,
                            color: (res['isCorrect'] ?? false) ? Colors.green : Colors.red,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
