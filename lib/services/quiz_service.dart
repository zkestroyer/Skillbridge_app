import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/career.dart';
import '../models/skill.dart';

class QuizService {
  static Future<List<Career>> loadCareers() async {
    final jsonString = await rootBundle.loadString('assets/data/careers.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    return jsonData
        .map((item) => Career.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Skill>> loadSkills() async {
    final jsonString = await rootBundle.loadString('assets/data/skills.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    return jsonData
        .map((item) => Skill.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
