import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/quiz_response.dart';

class LocalStorageService {
  static const String _quizResponseKey = 'quiz_response';
  static const String _completedSkillsKey = 'completed_skills';
  static const String _savedCareersKey = 'saved_careers';

  static Future<void> saveQuizResponse(QuizResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_quizResponseKey, jsonEncode(response.toJson()));
  }

  static Future<QuizResponse?> getQuizResponse() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_quizResponseKey);

    if (jsonString != null) {
      return QuizResponse.fromJson(jsonDecode(jsonString));
    }

    return null;
  }

  static Future<void> addCompletedSkill(int skillId) async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList(_completedSkillsKey) ?? [];

    if (!completed.contains(skillId.toString())) {
      completed.add(skillId.toString());
      await prefs.setStringList(_completedSkillsKey, completed);
    }
  }

  static Future<List<int>> getCompletedSkills() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList(_completedSkillsKey) ?? [];
    return completed.map((id) => int.parse(id)).toList();
  }

  static Future<void> saveCareer(int careerId) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_savedCareersKey) ?? [];

    if (!saved.contains(careerId.toString())) {
      saved.add(careerId.toString());
      await prefs.setStringList(_savedCareersKey, saved);
    }
  }

  static Future<List<int>> getSavedCareers() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_savedCareersKey) ?? [];
    return saved.map((id) => int.parse(id)).toList();
  }

  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_quizResponseKey);
    await prefs.remove(_completedSkillsKey);
    await prefs.remove(_savedCareersKey);
  }
}
