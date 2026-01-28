class Career {
  final int id;
  final String title;
  final String description;
  final String salary;
  final String demand;
  final List<String> skills;
  final String education;
  final String workEnvironment;
  final String growthOpportunity;
  final String icon;

  Career({
    required this.id,
    required this.title,
    required this.description,
    required this.salary,
    required this.demand,
    required this.skills,
    required this.education,
    required this.workEnvironment,
    required this.growthOpportunity,
    required this.icon,
  });

  factory Career.fromJson(Map<String, dynamic> json) {
    return Career(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      salary: json['salary'] as String,
      demand: json['demand'] as String,
      skills: List<String>.from(json['skills'] as List),
      education: json['education'] as String,
      workEnvironment: json['workEnvironment'] as String,
      growthOpportunity: json['growthOpportunity'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'salary': salary,
      'demand': demand,
      'skills': skills,
      'education': education,
      'workEnvironment': workEnvironment,
      'growthOpportunity': growthOpportunity,
      'icon': icon,
    };
  }
}
