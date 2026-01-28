import 'package:flutter/material.dart';
import 'career_list_screen.dart';
import '../models/quiz_response.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  late PageController _pageController;
  final List<String> _selectedAnswers = [];

  final List<Map<String, dynamic>> quizQuestions = [
    {
      'question': 'What interests you the most?',
      'options': [
        'Technology & Programming',
        'Design & Creativity',
        'Business & Leadership',
        'Healthcare & Helping Others',
        'Environment & Sustainability',
      ],
    },
    {
      'question': 'What is your current education level?',
      'options': [
        'Still in high school',
        'High school graduate',
        'Some college/vocational training',
        'Bachelor\'s degree',
        'Master\'s degree or higher',
      ],
    },
    {
      'question': 'How is your internet connectivity?',
      'options': [
        'Very Limited (< 1 hour/week)',
        'Limited (1-10 hours/week)',
        'Moderate (10-30 hours/week)',
        'Good (30+ hours/week)',
        'Excellent (Constant access)',
      ],
    },
    {
      'question': 'What is your financial constraint level?',
      'options': [
        'Very High - Need free resources',
        'High - Can afford some paid courses',
        'Moderate - Can invest in education',
        'Low - Budget is not a concern',
        'No financial constraint',
      ],
    },
    {
      'question': 'How many years until you want to be job-ready?',
      'options': [
        'Immediately or within 6 months',
        '6 months to 1 year',
        '1 to 2 years',
        '2 to 3 years',
        '3+ years (long-term planning)',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectAnswer(String answer) {
    if (_selectedAnswers.length <= _currentQuestion) {
      _selectedAnswers.add(answer);
    } else {
      _selectedAnswers[_currentQuestion] = answer;
    }

    if (_currentQuestion < quizQuestions.length - 1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      });
    } else {
      _submitQuiz();
    }
  }

  void _submitQuiz() {
    final quizResponse = QuizResponse(
      interests: _selectedAnswers[0],
      educationLevel: _selectedAnswers[1],
      internetAvailability: _selectedAnswers[2],
      financialConstraint: _selectedAnswers[3],
      timeframe: _selectedAnswers[4],
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => CareerListScreen(quizResponse: quizResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: _currentQuestion > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              )
            : null,
        title: Text(
          'Career Quiz',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (_currentQuestion + 1) / quizQuestions.length,
                minHeight: 6,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6366F1),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Question ${_currentQuestion + 1} of ${quizQuestions.length}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF6366F1),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentQuestion = index;
                });
              },
              itemCount: quizQuestions.length,
              itemBuilder: (context, index) {
                final question = quizQuestions[index];
                return _buildQuestionPage(
                  question['question'] as String,
                  question['options'] as List<String>,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionPage(String question, List<String> options) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            question,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 40),
          ...options.asMap().entries.map((entry) {
            final option = entry.value;
            final isSelected = _selectedAnswers.length > _currentQuestion &&
                _selectedAnswers[_currentQuestion] == option;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => _selectAnswer(option),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected
                        ? const Color(0xFF6366F1).withOpacity(0.1)
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF6366F1)
                                : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                          color: isSelected
                              ? const Color(0xFF6366F1)
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? const Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          option,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: isSelected
                                        ? const Color(0xFF6366F1)
                                        : Colors.black87,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
