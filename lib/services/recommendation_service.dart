import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/career.dart';
import '../models/skill.dart';
import '../models/quiz_response.dart';

class RecommendationService {
  static Future<List<Career>> getRecommendations(QuizResponse response) async {
    final jsonString = await rootBundle.loadString('assets/data/careers.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    final careers = jsonData
        .map((item) => Career.fromJson(item as Map<String, dynamic>))
        .toList();

    // Simple recommendation logic based on interests
    final recommendedCareers = _filterByInterests(careers, response.interests);

    return recommendedCareers;
  }

  static List<Career> _filterByInterests(
    List<Career> careers,
    String interests,
  ) {
    // Map interests to relevant career fields
    final interestMap = {
      'Technology & Programming': [
        'programming',
        'code',
        'software',
        'developer'
      ],
      'Design & Creativity': ['design', 'creative', 'ui', 'ux'],
      'Business & Leadership': ['business', 'manager', 'analyst', 'product'],
      'Healthcare & Helping Others': [
        'health',
        'care',
        'medical',
        'technician'
      ],
      'Environment & Sustainability': [
        'environment',
        'renewable',
        'sustainable'
      ],
    };

    final keywords = interestMap[interests] ?? [];

    return careers.where((career) {
      final titleLower = career.title.toLowerCase();
      final descLower = career.description.toLowerCase();
      return keywords.any(
        (keyword) =>
            titleLower.contains(keyword) || descLower.contains(keyword),
      );
    }).toList();
  }

  static Future<List<Skill>> getSkillsForCareer(int careerId) async {
    final jsonString = await rootBundle.loadString('assets/data/skills.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    final skills = jsonData
        .map((item) => Skill.fromJson(item as Map<String, dynamic>))
        .toList();

    return skills
        .where((skill) => skill.relevantCareers.contains(careerId))
        .toList();
  }
}
