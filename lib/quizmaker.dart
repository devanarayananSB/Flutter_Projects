import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizMakerPage extends StatefulWidget {
  const QuizMakerPage({super.key});

  @override
  _QuizMakerPageState createState() => _QuizMakerPageState();
}

class _QuizMakerPageState extends State<QuizMakerPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _questionController = TextEditingController();
  final _optionControllers = List.generate(4, (_) => TextEditingController());
  String? _selectedSubject;
  String? _correctAnswer;

  final List<String> _subjects = [
    'MERN',
    'Python',
    'UI/UX',
    'Flutter',
    'DevOps',
    'Cyber Security',
    'Network Engineering',
    'Digital Marketing',
    'PHP',
  ];

  Future<void> saveQuiz() async {
    if (_selectedSubject == null ||
        _correctAnswer == null ||
        _questionController.text.isEmpty ||
        _optionControllers.any((controller) => controller.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      await _firestore.collection('quizzes').doc(_selectedSubject).collection('questions').add({
        'question': _questionController.text.trim(),
        'options': _optionControllers.map((controller) => controller.text.trim()).toList(),
        'correctAnswer': _correctAnswer,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz question saved successfully!')),
      );

      // Clear fields after saving
      _questionController.clear();
      for (var controller in _optionControllers) {
        controller.clear();
      }
      setState(() {
        _correctAnswer = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save question: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Maker'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedSubject,
                hint: const Text('Select Subject'),
                items: _subjects.map((subject) {
                  return DropdownMenuItem(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSubject = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: _optionControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Option ${index + 1}',
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (_) {
                      setState(() {}); // Update dropdown when options change
                    },
                  ),
                );
              }),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _correctAnswer,
                hint: const Text('Select Correct Answer'),
                items: _optionControllers
                    .where((controller) => controller.text.isNotEmpty)
                    .map((controller) {
                  return DropdownMenuItem(
                    value: controller.text,
                    child: Text(controller.text),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _correctAnswer = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: saveQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Save Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
