class QuizResponse {
  final String interests;
  final String educationLevel;
  final String internetAvailability;
  final String financialConstraint;
  final String timeframe;

  QuizResponse({
    required this.interests,
    required this.educationLevel,
    required this.internetAvailability,
    required this.financialConstraint,
    required this.timeframe,
  });

  Map<String, dynamic> toJson() {
    return {
      'interests': interests,
      'educationLevel': educationLevel,
      'internetAvailability': internetAvailability,
      'financialConstraint': financialConstraint,
      'timeframe': timeframe,
    };
  }

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      interests: json['interests'] as String,
      educationLevel: json['educationLevel'] as String,
      internetAvailability: json['internetAvailability'] as String,
      financialConstraint: json['financialConstraint'] as String,
      timeframe: json['timeframe'] as String,
    );
  }
}
