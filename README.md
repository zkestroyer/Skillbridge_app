# SkillBridge+ 🌟

## Quality Education for All — Aligned with UN SDG 4

SkillBridge+ is an **offline-first career guidance application** designed for underserved students in low-resource environments. It helps students discover suitable careers, build skill roadmaps, and track their learning progress—all without requiring continuous internet access.

---

## 🎯 How the Application Works

SkillBridge+ guides students through a structured journey to career discovery and skill development:

1. **Onboarding**: Learn about the problem of limited career guidance in underserved communities and how SkillBridge+ solves it.

2. **Career Discovery Quiz**: Answer 4 questions about your:
   - Interests and strengths
   - Current education level
   - Internet availability
   - Financial constraints

3. **Smart Recommendations**: Receive 2-4 career recommendations based on your answers, matched using a transparent, rule-based algorithm.

4. **Career Exploration**: View detailed information about each recommended career, including description, suitability reasons, and required skills.

5. **Skill Roadmap**: Access a structured learning path organized into three levels:
   - **Beginner Skills**: Foundation knowledge
   - **Intermediate Skills**: Build on basics
   - **Advanced Skills**: Master the topic
   
   Track your progress by checking off completed skills.

6. **Progress Dashboard**: Monitor your overall learning progress with:
   - Progress percentage
   - Motivational messages
   - Skill statistics
   - Learning tips and encouragement

---

## 👥 User-Level Requirements

### For Students
- **Ages**: 13-25 years old (secondary to early tertiary education)
- **Technical Skill**: No prior tech knowledge required
- **Hardware**: Android smartphone or tablet
- **Internet**: Works completely offline (no WiFi/data required)
- **Time Commitment**: 10-15 minutes for quiz, 1-2 hours for skill exploration

### Supported Student Profiles
- Students in low-internet environments (rural areas, developing regions)
- Students from low-income backgrounds
- Students without access to career counseling services
- First-generation learners in technology fields

### Accessibility Features
- Simple, intuitive UI with clear navigation
- Large, readable text
- Color-coded skill levels
- Progress visualization
- Offline functionality for unreliable connectivity

---

## 📋 Project Overview

**Platform:** Android (Flutter)  
**Architecture:** MVVM-like with Models, Services, and Screens  
**Storage:** SharedPreferences (local) + JSON assets  
**Target:** 24-hour hackathon MVP  
**SDG Alignment:** Goal 4 - Quality Education for All

---

## 🎯 Core Features

✅ **Offline-First Architecture**
- No backend required for MVP
- All data stored locally in JSON and SharedPreferences
- Works on low-bandwidth devices

✅ **Smart Career Discovery Quiz**
- Assess student interests, education level, internet access, and financial constraints
- Save responses locally for future reference

✅ **Rule-Based Career Recommendations**
- Deterministic, explainable matching algorithm
- Filter by education level and internet availability
- Score careers based on interest alignment
- Returns 2-4 most suitable careers

✅ **Skill Roadmap**
- Organized by proficiency level: Beginner → Intermediate → Advanced
- Checkbox-based progress tracking
- Locally persisted completion status

✅ **Progress Tracking**
- Real-time progress percentage calculation
- Motivation messages based on progress
- Statistics dashboard
- Learning tips and encouragement

✅ **User-Friendly Navigation**
- Splash screen with SDG 4 branding
- Onboarding explaining the problem and solution
- Smooth screen transitions

---

## 📁 Project Structure

```
skillbridge_plus/
│
├── lib/
│   ├── main.dart                    # App entry point & navigation
│   │
│   ├── core/
│   │   ├── constants.dart           # App constants & quiz options
│   │   └── theme.dart               # Material UI theme
│   │
│   ├── models/
│   │   ├── career.dart              # Career data model
│   │   ├── skill.dart               # Skill data model
│   │   └── quiz_response.dart       # Quiz response model
│   │
│   ├── data/
│   │   ├── careers.json             # Career database (8 careers)
│   │   └── skills.json              # Skills database (30 skills)
│   │
│   ├── services/
│   │   ├── local_storage_service.dart    # SharedPreferences wrapper
│   │   ├── quiz_service.dart             # Quiz logic
│   │   └── recommendation_service.dart   # Career recommendation engine
│   │
│   ├── screens/
│   │   ├── splash_screen.dart            # Branding & SDG 4
│   │   ├── onboarding_screen.dart        # Problem/Solution explanation
│   │   ├── quiz_screen.dart              # Multi-step quiz (4 pages + summary)
│   │   ├── career_list_screen.dart       # Recommended careers list
│   │   ├── career_detail_screen.dart     # Career overview
│   │   ├── roadmap_screen.dart           # Skill roadmap with checkboxes
│   │   └── progress_screen.dart          # Progress dashboard
│   │
│   └── widgets/
│       ├── progress_bar.dart        # Reusable progress indicator
│       └── skill_tile.dart          # Skill checkbox tile
│
├── assets/
│   └── data/
│       ├── careers.json             # Career metadata
│       └── skills.json              # Skill metadata
│
├── pubspec.yaml                     # Dependencies
└── README.md                        # This file
```

---

## 🔧 Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** setState (lightweight MVP)
- **Local Storage:** shared_preferences
- **Data:** JSON assets
- **UI:** Material 3 Design System

---

## 📊 Data Models

### Career
```json
{
  "id": "frontend_dev",
  "title": "Frontend Developer",
  "description": "...",
  "suitable_for": ["creative", "logical", "technology"],
  "education_level": ["intermediate", "undergraduate"],
  "low_internet_friendly": true,
  "skills": ["html", "css", "flutter", "ui_design"]
}
```

### Skill
```json
{
  "html": {
    "title": "HTML Basics",
    "level": "beginner"
  }
}
```

### Quiz Response (stored locally)
```json
{
  "interests": ["Technology", "Design"],
  "education_level": "School",
  "internet_availability": "Low",
  "has_financial_constraint": true,
  "timestamp": "2026-01-27T10:30:00.000Z"
}
```

---

## 🧠 Recommendation Algorithm

The system uses **rule-based matching** (explainable to judges):

1. **Filter by Internet Availability**: If user selects "Low", show only low-internet-friendly careers
2. **Filter by Education Level**: Match career requirements with user's education
3. **Score by Interests**: Award points for each interest match
4. **Sort & Return**: Return top 2-4 careers

**Why no AI?** 
- More explainable to judges
- Works completely offline
- Faster execution
- Deterministic results

---

## 💾 Local Storage

**SharedPreferences keys:**
- `quiz_responses` → Stores quiz answers (JSON string)
- `selected_career` → Currently viewing career ID
- `completed_skills` → List of completed skill IDs
- `onboarding_complete` → Boolean flag

**Benefits:**
- Privacy-first (no data leaves device)
- Instant access (no network latency)
- Works offline indefinitely
- Minimal storage footprint (~few KB)

---

## 🎨 App Flow

```
Splash (2s) 
    ↓
Onboarding (problem/solution)
    ↓
Quiz (4 pages + summary)
    ↓
Career Recommendations (list with scores)
    ↓
Career Detail (overview & skills)
    ↓
Roadmap (3-level skill progression)
    ↓
Progress Tracker (dashboard & motivation)
```

---

## 🚀 Running the App

### Prerequisites
- Flutter SDK 3.0+
- Android SDK (for APK generation)

### Setup
```bash
cd skillbridge_plus
flutter pub get
flutter run
```

### Build APK
```bash
flutter build apk --release
# APK will be at: build/app/outputs/flutter-apk/app-release.apk
```

---

## ✅ Testing Checklist

Before submission:
- [ ] App launches without crashes
- [ ] Splash screen displays for 2 seconds
- [ ] Onboarding explains SDG 4 alignment
- [ ] Quiz submits all 4 pages correctly
- [ ] Career list shows recommendations
- [ ] Career detail displays all information
- [ ] Skill roadmap loads and saves progress
- [ ] Progress tracker updates on skill completion
- [ ] All navigation works smoothly
- [ ] App persists data after restart
- [ ] No network requests (100% offline)

---

## 🌍 SDG 4 Alignment

**Sustainable Development Goal 4: Quality Education**

SkillBridge+ directly supports SDG 4 by:
- 🎓 **Inclusive Education**: Accessible to students in underserved communities
- 🌐 **Low-Internet Friendly**: Works in offline-first mode
- 💡 **Career Guidance**: Helps students make informed educational choices
- 🛣️ **Skill Roadmaps**: Provides clear pathways to employment
- 📊 **Progress Tracking**: Monitors and motivates lifelong learning

> "Ensure inclusive and equitable quality education and promote lifelong learning opportunities for all"

---

## 🔮 Future Enhancements (Post-MVP)

1. **Backend Integration** (Firebase/Supabase)
   - Cloud sync for cross-device progress
   - User accounts and profiles

2. **Mentorship Module**
   - Connect with professionals in each career field
   - Q&A and guidance

3. **Localization**
   - Support for multiple languages
   - Regional career data

4. **Assessment Features**
   - Quiz-based skill verification
   - Certificates of completion

5. **Community Features**
   - Discussion forums
   - Peer learning groups

---

## 📝 Notes for Judges

✅ **Original Code**: All code written from scratch for this hackathon  
✅ **Explainable Logic**: No AI/ML black boxes—rule-based recommendations  
✅ **MVP Focus**: Core features only, no unnecessary complexity  
✅ **Offline-First**: Demonstrates accessibility for low-resource environments  
✅ **Architecture**: Clean MVVM-like structure for maintainability  
✅ **SDG Alignment**: Clear connection to UN SDG 4 throughout

---

## � Team Information

**Team Name:** SkillBridge+ Development Team

**Team Members:**
- Zainab Khan
- Mohid Ahmer Khan
- Ubaid Raza

---

## 📄 License

This project is open-source and available under the MIT License.

---

## 🤝 Contributing

This is a hackathon submission. For improvements or bug reports, please create an issue or pull request.

---

**Last Updated**: January 27, 2026  
**Status**: ✅ MVP Complete
