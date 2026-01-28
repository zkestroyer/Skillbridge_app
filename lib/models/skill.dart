class Skill {
  final int id;
  final String name;
  final String description;
  final String level;
  final List<int> relevantCareers;
  final List<String> resources;
  final String difficulty;
  final String timeToLearn;
  final String icon;

  Skill({
    required this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.relevantCareers,
    required this.resources,
    required this.difficulty,
    required this.timeToLearn,
    required this.icon,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      level: json['level'] as String,
      relevantCareers: List<int>.from(json['relevantCareers'] as List),
      resources: List<String>.from(json['resources'] as List),
      difficulty: json['difficulty'] as String,
      timeToLearn: json['timeToLearn'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'level': level,
      'relevantCareers': relevantCareers,
      'resources': resources,
      'difficulty': difficulty,
      'timeToLearn': timeToLearn,
      'icon': icon,
    };
  }
}
