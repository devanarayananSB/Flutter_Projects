import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectQuizPage extends StatefulWidget {
  final String subject;

  const SubjectQuizPage({super.key, required this.subject});

  @override
  State<SubjectQuizPage> createState() => _SubjectQuizPageState();
}

class _SubjectQuizPageState extends State<SubjectQuizPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Map to store selected answers
  Map<String, String?> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Quiz'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('quizzes') // Main collection
            .doc(widget.subject) // Document with subject name
            .collection('questions') // Sub-collection for questions
            .snapshots(),
        builder: (context, snapshot) {
          // Handle connection states
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Failed to load questions.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No questions available for ${widget.subject}.'));
          }

          final questions = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final questionData = questions[index];
                    final questionId = questionData.id;
                    final question = questionData['question'];
                    final options = List<String>.from(questionData['options'] ?? []);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display the question
                              Text(
                                'Q${index + 1}: $question',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Display the options
                              ...options.map((option) {
                                return ListTile(
                                  title: Text(option),
                                  leading: Radio<String>(
                                    value: option,
                                    groupValue: selectedAnswers[questionId],
                                    onChanged: (val) {
                                      setState(() {
                                        selectedAnswers[questionId] = val; // Save selected answer
                                      });
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Submit Button
             Padding(
  padding: const EdgeInsets.all(16.0),
  child: ElevatedButton.icon(
    onPressed: () => submitResults(questions),
    icon: const Icon(Icons.send),
    label: const Text(
      'Submit',
      style: TextStyle(fontSize: 16),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.yellow,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
),

            ],
          );
        },
      ),
    );
  }

  Future<void> submitResults(List<QueryDocumentSnapshot> questions) async {
    // Prepare results to submit
    final results = questions.map((questionData) {
      final questionId = questionData.id;
      final question = questionData['question'];
      final correctAnswer = questionData['correctAnswer'];
      final userAnswer = selectedAnswers[questionId];

      return {
        'question': question,
        'correctAnswer': correctAnswer,
        'userAnswer': userAnswer,
        'isCorrect': userAnswer == correctAnswer,
      };
    }).toList();

    // Send results to Firestore (admin accessible collection)
    try {
      await _firestore.collection('results').add({
        'subject': widget.subject,
        'submittedAt': DateTime.now(),
        'results': results,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Answers submitted successfully!')),
      );

      Navigator.pop(context); // Navigate back after submission
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit answers: $e')),
      );
    }
  }
}
