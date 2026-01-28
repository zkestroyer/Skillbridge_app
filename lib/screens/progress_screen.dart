import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/skill.dart';
import '../models/career.dart';

class ProgressScreen extends StatefulWidget {
  final Career? selectedCareer;

  const ProgressScreen({
    Key? key,
    this.selectedCareer,
  }) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with SingleTickerProviderStateMixin {
  late Future<Map<String, dynamic>> _learningPathFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _learningPathFuture = _loadLearningPath();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> _loadLearningPath() async {
    final skillsJson = await rootBundle.loadString('assets/data/skills.json');
    final careersJson = await rootBundle.loadString('assets/data/careers.json');

    final skillsData = json.decode(skillsJson) as List<dynamic>;
    final careersData = json.decode(careersJson) as List<dynamic>;

    final skills = skillsData
        .map((item) => Skill.fromJson(item as Map<String, dynamic>))
        .toList();

    final careers = careersData
        .map((item) => Career.fromJson(item as Map<String, dynamic>))
        .toList();

    return {
      'skills': skills,
      'careers': careers,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Learning Paths',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Roadmap'),
            Tab(text: 'All Skills'),
          ],
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _learningPathFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final skills = snapshot.data?['skills'] as List<Skill>? ?? [];
          final careers = snapshot.data?['careers'] as List<Career>? ?? [];

          return TabBarView(
            controller: _tabController,
            children: [
              _buildRoadmapTab(context, skills, careers),
              _buildAllSkillsTab(context, skills),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRoadmapTab(
    BuildContext context,
    List<Skill> skills,
    List<Career> careers,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Learning Journey',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete this roadmap to master your chosen career path',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 32),
          _buildPhase(
            context,
            'Phase 1: Foundations',
            'Master the basics',
            [
              skills.firstWhere((s) => s.name == 'Communication',
                  orElse: () => skills[5]),
              skills.firstWhere(
                  (s) => s.name == 'Problem-Solving & Critical Thinking',
                  orElse: () => skills[9]),
            ],
            Colors.blue,
            isActive: true,
          ),
          const SizedBox(height: 20),
          _buildPhase(
            context,
            'Phase 2: Core Skills',
            'Build professional expertise',
            [
              skills.firstWhere((s) => s.name == 'Programming',
                  orElse: () => skills[0]),
              skills.firstWhere((s) => s.name == 'Data Analysis',
                  orElse: () => skills[1]),
              skills.firstWhere((s) => s.name == 'Digital Marketing',
                  orElse: () => skills[8]),
            ],
            Colors.purple,
          ),
          const SizedBox(height: 20),
          _buildPhase(
            context,
            'Phase 3: Advanced Topics',
            'Specialize in your field',
            [
              skills.firstWhere((s) => s.name == 'Machine Learning',
                  orElse: () => skills[2]),
              skills.firstWhere((s) => s.name == 'Cybersecurity',
                  orElse: () => skills[6]),
              skills.firstWhere((s) => s.name == 'Project Management',
                  orElse: () => skills[4]),
            ],
            Colors.orange,
          ),
          const SizedBox(height: 20),
          _buildPhase(
            context,
            'Phase 4: Mastery',
            'Become an expert',
            [
              skills.firstWhere((s) => s.name == 'UI/UX Design',
                  orElse: () => skills[3]),
              skills.firstWhere(
                  (s) => s.name == 'Sustainability & Environmental Science',
                  orElse: () => skills[7]),
            ],
            Colors.green,
          ),
          const SizedBox(height: 32),
          _buildProgressSummary(context),
        ],
      ),
    );
  }

  Widget _buildPhase(
    BuildContext context,
    String title,
    String subtitle,
    List<Skill> skills,
    Color color, {
    bool isActive = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
        color: isActive ? color.withOpacity(0.08) : Colors.grey[50],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              if (isActive)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'In Progress',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ...skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;
            return Padding(
              padding:
                  EdgeInsets.only(bottom: index == skills.length - 1 ? 0 : 12),
              child: _buildSkillItem(context, skill, color),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSkillItem(BuildContext context, Skill skill, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Text(
            skill.icon,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skill.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '${skill.difficulty} • ${skill.timeToLearn}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              skill.level,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllSkillsTab(BuildContext context, List<Skill> skills) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Skills',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explore and learn any skill from our library',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 20),
          ...skills.map((skill) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildSkillCard(context, skill),
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, Skill skill) {
    final colors = [
      const Color(0xFF6366F1),
      const Color(0xFF8B5CF6),
      const Color(0xFFEC4899),
      const Color(0xFF06B6D4),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEF4444),
      const Color(0xFF3B82F6),
      const Color(0xFFD946EF),
      const Color(0xFF14B8A6),
    ];

    final cardColor = colors[skill.id % colors.length];

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => _buildSkillDetails(context, skill, cardColor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [cardColor, cardColor.withOpacity(0.7)],
          ),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  skill.icon,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skill.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        skill.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                _buildBadge(
                    '${skill.difficulty}', Colors.white.withOpacity(0.3)),
                _buildBadge(skill.timeToLearn, Colors.white.withOpacity(0.3)),
                _buildBadge(skill.level, Colors.white.withOpacity(0.2)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSkillDetails(BuildContext context, Skill skill, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                skill.icon,
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      skill.level,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            skill.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            'Learning Details',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Difficulty', skill.difficulty),
              _buildDetailItem('Time', skill.timeToLearn),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Learning Resources',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          ...skill.resources.asMap().entries.map((entry) {
            final index = entry.key;
            final resource = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                  bottom: index == skill.resources.length - 1 ? 0 : 12),
              child: Row(
                children: [
                  Icon(Icons.link, color: color, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      resource,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Started learning ${skill.name}!'),
                    backgroundColor: color,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Start Learning This Skill'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Widget _buildProgressSummary(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6366F1),
            const Color(0xFF6366F1).withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress Summary',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgressStat('Skills Started', '3', Colors.white),
              _buildProgressStat('In Progress', '2', Colors.white),
              _buildProgressStat('Completed', '1', Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStat(String label, String value, Color textColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: textColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
