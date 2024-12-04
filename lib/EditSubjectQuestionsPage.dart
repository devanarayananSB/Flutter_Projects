import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditSubjectQuestionsPage extends StatefulWidget {
  final String subject;

  const EditSubjectQuestionsPage({super.key, required this.subject});

  @override
  _EditSubjectQuestionsPageState createState() =>
      _EditSubjectQuestionsPageState();
}

class _EditSubjectQuestionsPageState extends State<EditSubjectQuestionsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateQuestion(String questionId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore
          .collection('quizzes')
          .doc(widget.subject)
          .collection('questions')
          .doc(questionId)
          .update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Question updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update question: $e')),
      );
    }
  }

  Future<void> deleteQuestion(String questionId) async {
    try {
      await _firestore
          .collection('quizzes')
          .doc(widget.subject)
          .collection('questions')
          .doc(questionId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Question deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete question: $e')),
      );
    }
  }

  void showEditDialog(String questionId, Map<String, dynamic> questionData) {
    final TextEditingController questionController =
        TextEditingController(text: questionData['question']);
    final TextEditingController correctAnswerController =
        TextEditingController(text: questionData['correctAnswer']);
    final List<TextEditingController> optionControllers = List.generate(
      questionData['options'].length,
      (index) => TextEditingController(text: questionData['options'][index]),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Question'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: questionController,
                  decoration: const InputDecoration(labelText: 'Question'),
                ),
                TextField(
                  controller: correctAnswerController,
                  decoration: const InputDecoration(labelText: 'Correct Answer'),
                ),
                ...optionControllers.map((controller) {
                  return TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'Option'),
                  );
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedData = {
                  'question': questionController.text,
                  'correctAnswer': correctAnswerController.text,
                  'options': optionControllers.map((c) => c.text).toList(),
                };
                updateQuestion(questionId, updatedData);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.subject} Questions'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('quizzes')
            .doc(widget.subject)
            .collection('questions')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching questions'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No questions available for ${widget.subject}.'),
            );
          }

          final questions = snapshot.data!.docs;

          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final questionData = questions[index].data() as Map<String, dynamic>;
              final questionId = questions[index].id;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    questionData['question'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () =>
                            showEditDialog(questionId, questionData),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteQuestion(questionId),
                      ),
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
