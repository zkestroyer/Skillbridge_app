import 'package:flutter/material.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Roadmap'),
      ),
      body: const Center(
        child: Text('Learning Roadmap'),
      ),
    );
  }
}
