# SkillBridge+ Architecture & Design Document

## System Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                     Flutter App (Main)                      │
│                    Navigation Routes                        │
└─────────────────────────────────────────────────────────────┘
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
    ┌───▼──────────┐   ┌────▼─────┐       ┌────▼──────────┐
    │  UI Layer    │   │Services  │       │  Data Layer   │
    │  (Screens)   │   │ (Logic)  │       │  (Storage)    │
    └─────────────┘   └──────────┘       └──────────────┘
        │                   │                   │
        │                   │              ┌────▼──────────┐
        │              ┌────▼─────┐        │ SharedPrefs   │
        │              │ Recommend │        │ (Local Cache) │
        │              │ Service   │        └───────────────┘
        │              └──────────┘
        │                   │
        │                   │         ┌──────────────────┐
        │              ┌────▼─────┐   │   JSON Assets    │
        │              │ Quiz      │   │ careers.json     │
        │              │ Service   │   │ skills.json      │
        │              └──────────┘   └──────────────────┘
        │                   │
        │              ┌────▼──────────┐
        │              │ Storage       │
        │              │ Service       │
        │              └───────────────┘
```

---

## Layer Breakdown

### 1. Data Layer
**Location**: `assets/data/` + `lib/services/local_storage_service.dart`

**Responsibilities**:
- Store and retrieve user data
- Manage persistent state
- Serve static reference data

**Components**:
- `careers.json` - 8 careers with metadata
- `skills.json` - 30 skills with levels
- `SharedPreferences` - Quiz responses, completed skills

**Key Classes**:
```dart
class LocalStorageService {
  // CRUD operations for user data
  Future<void> saveQuizResponse(QuizResponse response);
  QuizResponse? getQuizResponse();
  List<String> getCompletedSkills();
}
```

### 2. Service Layer
**Location**: `lib/services/`

**Responsibilities**:
- Business logic
- Data transformation
- Recommendation engine

**Components**:

#### 2a. RecommendationService
```dart
class RecommendationService {
  // Rule-based career matching
  List<Career> getRecommendations(QuizResponse response) {
    // 1. Filter by internet availability
    // 2. Filter by education level
    // 3. Score by interests
    // 4. Return top 4
  }
}
```

**Algorithm Explanation**:
```
Input: Quiz Response
  ├─ Interests: [Technology, Design]
  ├─ Education Level: School
  ├─ Internet: Low
  └─ Financial Constraint: Yes

Processing:
  Step 1: Filter low-internet careers only
    Result: 7 careers
  
  Step 2: Match education level (School)
    Result: 5 careers
  
  Step 3: Score by interests
    Career A: 3 points (Technology + Design + logical)
    Career B: 2 points (Technology only)
    Career C: 1 point (Teaching)
    Career D: 0 points
    Career E: 2 points
  
  Step 4: Sort & Return Top 4
    Return: [A, B, E, C]
```

#### 2b. QuizService
```dart
class QuizService {
  // Quiz validation
  static bool isQuizComplete(QuizResponse response);
  
  // Response creation
  static QuizResponse createResponse({...});
}
```

#### 2c. LocalStorageService
```dart
class LocalStorageService {
  // Data persistence
  Future<void> saveQuizResponse(QuizResponse response);
  Future<void> addCompletedSkill(String skillId);
  List<String> getCompletedSkills();
}
```

### 3. Domain/Model Layer
**Location**: `lib/models/`

**Responsibilities**:
- Define data structures
- Provide serialization/deserialization

**Models**:

```dart
// Career model
class Career {
  String id;                 // Unique identifier
  String title;              // Display name
  String description;        // Long description
  List<String> suitableFor;  // Interest tags
  List<String> educationLevel;
  bool lowInternetFriendly;  // Offline capability
  List<String> skills;       // Required skill IDs
}

// Skill model
class Skill {
  String id;                 // Unique identifier
  String title;              // Display name
  String level;              // beginner/intermediate/advanced
}

// Quiz response model
class QuizResponse {
  List<String> interests;
  String educationLevel;
  String internetAvailability;
  bool hasFinancialConstraint;
  DateTime timestamp;
}
```

### 4. UI Layer (Screens)
**Location**: `lib/screens/`

**Screen Hierarchy**:
```
Splash Screen
    ↓
Onboarding Screen
    ↓
Quiz Screen (Multi-page)
    ├─ Page 1: Interests
    ├─ Page 2: Education
    ├─ Page 3: Internet
    ├─ Page 4: Financial
    └─ Page 5: Summary
    ↓
Career List Screen
    ↓
Career Detail Screen
    ↓
Roadmap Screen (Skill Tree)
    ↓
Progress Screen (Dashboard)
```

**Screen Responsibilities**:

| Screen | Purpose | State | Navigation |
|--------|---------|-------|-----------|
| SplashScreen | Branding, SDG 4 | Stateful | → Onboarding |
| OnboardingScreen | Explain app | Stateless | → Quiz |
| QuizScreen | Collect user data | Stateful | → Careers |
| CareerListScreen | Show recommendations | Stateful | → Detail |
| CareerDetailScreen | Career overview | Stateful | → Roadmap |
| RoadmapScreen | Skill tracking | Stateful | ↔ Progress |
| ProgressScreen | Progress dashboard | Stateful | → Careers |

### 5. Widget Layer
**Location**: `lib/widgets/`

**Reusable Components**:

```dart
// Progress indicator
class ProgressBar extends StatelessWidget {
  double progress;  // 0.0 to 1.0
  String label;
}

// Skill checkbox tile
class SkillTile extends StatefulWidget {
  String skillId;
  String skillTitle;
  String skillLevel;
  bool isCompleted;
  Function(bool) onChanged;  // Calls storage service
}
```

---

## Data Flow Diagrams

### Quiz → Recommendation Flow
```
┌─ Quiz Screen
│  ├─ User selects interests
│  ├─ User selects education level
│  ├─ User selects internet availability
│  └─ User indicates financial constraints
│
└─ LocalStorageService.saveQuizResponse()
   └─ SharedPreferences (JSON string)
      └─ Career List Screen loads
         └─ RecommendationService.getRecommendations()
            ├─ Load all careers from JSON
            ├─ Filter by internet availability
            ├─ Filter by education level
            ├─ Score by interest match
            └─ Return top 4
```

### Skill Progress Flow
```
┌─ Roadmap Screen
│  ├─ Load career from argument
│  ├─ Load skills from skills.json
│  ├─ Load completed skills from SharedPreferences
│  └─ Display SkillTile widgets
│
└─ User checks skill checkbox
   └─ SkillTile.onChanged() called
      └─ LocalStorageService.addCompletedSkill(skillId)
         └─ SharedPreferences updated
            └─ Progress Screen reads data
               └─ Progress bar updates
```

---

## State Management Strategy

**Pattern**: setState (Lightweight MVP)

**Why not Provider/Bloc?**
- MVP (Minimal Viable Product)
- Simple data flow (unidirectional)
- Services handle business logic
- Screens are mostly independent

**State in Each Screen**:
```dart
// QuizScreen
List<String> selectedInterests;
String? selectedEducationLevel;
String? selectedInternetAvailability;
bool hasFinancialConstraint;

// CareerListScreen
List<Career> recommendedCareers;
bool _isLoading;

// RoadmapScreen
List<Skill> beginnerSkills;
List<Skill> intermediateSkills;
List<Skill> advancedSkills;
List<String> completedSkills;

// ProgressScreen
List<String> completedSkills;
int totalSkills;
```

---

## Navigation Structure

**Named Routes** (in `main.dart`):
```dart
routes: {
  '/onboarding': OnboardingScreen(...),
  '/quiz': QuizScreen(...),
  '/careers': CareerListScreen(...),
  '/career-detail': CareerDetailScreen(...),
  '/roadmap': RoadmapScreen(...),
  '/progress': ProgressScreen(...),
}
```

**Navigation Pattern**:
- Push named route: `Navigator.pushNamed(context, '/careers')`
- Replace (replace current): `Navigator.pushReplacementNamed(context, '/quiz')`
- Pop (go back): `Navigator.pop(context)`

**Route Arguments**:
```dart
// Career Detail Screen
Navigator.pushNamed(context, '/career-detail', arguments: careerId);

// Retrieve in screen
final careerId = ModalRoute.of(context)!.settings.arguments as String?;
```

---

## Local Storage Schema

### SharedPreferences Keys
```
Key: "quiz_responses"
Type: String (JSON)
Value: {
  "interests": ["Technology", "Design"],
  "education_level": "school",
  "internet_availability": "low",
  "has_financial_constraint": true,
  "timestamp": "2026-01-27T10:30:00.000Z"
}

Key: "selected_career"
Type: String
Value: "frontend_dev"

Key: "completed_skills"
Type: List<String>
Value: ["html", "css", "flutter"]

Key: "onboarding_complete"
Type: Boolean
Value: true
```

---

## Recommendation Algorithm Deep Dive

**Goal**: Match user profile to career without AI/ML

**Input**: QuizResponse with 4 attributes

**Filtering**:
```dart
// Constraint 1: Internet availability
if (response.internetAvailability == 'Low') {
  careers = careers.where((c) => c.lowInternetFriendly).toList();
  // Only careers with low_internet_friendly: true
}

// Constraint 2: Education level
careers = careers.where((c) => 
  c.educationLevel.contains(
    response.educationLevel.toLowerCase()
  )
).toList();
```

**Scoring**:
```dart
for (var career in filteredCareers) {
  int score = 0;
  
  // Interest matching
  for (var userInterest in response.interests) {
    if (career.suitableFor.contains(userInterest.toLowerCase())) {
      score += 2;  // Direct match
    }
  }
  
  // Bonus points
  if (response.interests.contains('Teaching') && 
      career.suitableFor.contains('teaching')) {
    score += 1;  // Category match
  }
}
```

**Ranking**:
```dart
// Sort by score descending
careerScores.sort((a, b) => b.value.compareTo(a.value));

// Return top 4
return careerScores.take(4).map((e) => e.key).toList();
```

---

## Error Handling

**Strategy**: Graceful degradation

```dart
// In services
Career? getCareerById(String id) {
  try {
    return allCareers.firstWhere((c) => c.id == id);
  } catch (e) {
    return null;  // Return null if not found
  }
}

// In screens
if (career == null) {
  return Center(child: Text('Career not found'));
}
```

**JSON Loading**:
```dart
try {
  final jsonString = await rootBundle.loadString('assets/data/careers.json');
  final list = jsonDecode(jsonString);
  allCareers = list.map((j) => Career.fromJson(j)).toList();
} catch (e) {
  print('Error loading careers: $e');
  // Fallback to empty list
}
```

---

## Performance Optimization

1. **Single Load**
   - Careers loaded once at app init
   - Cached in `RecommendationService`

2. **Lazy Loading**
   - Skills loaded only when viewing roadmap
   - Reduces initial load time

3. **Minimal Serialization**
   - Only quiz response serialized to JSON
   - Skills use list operations

4. **Efficient Filtering**
   - Linear scan (n=8 careers) is fast
   - Scoring is O(n*m) where m=4 interests (acceptable)

---

## Testing Strategy

### Unit Tests
```dart
// Test recommendation algorithm
test('Low internet filters careers', () {
  final response = QuizResponse(
    internetAvailability: 'Low',
    // ...
  );
  final recs = service.getRecommendations(response);
  expect(recs.every((c) => c.lowInternetFriendly), true);
});
```

### Integration Tests
```dart
// Test full quiz flow
test('Quiz and recommendations', () async {
  // Complete quiz
  // Check recommendations returned
  // Navigate to career detail
  // Verify career loads
});
```

### Manual Testing
- ✅ App launches
- ✅ Quiz saves data
- ✅ Recommendations appear
- ✅ Career details load
- ✅ Skills can be toggled
- ✅ Progress updates
- ✅ App persists after restart

---

## Future Architecture Improvements

1. **Provider for State Management**
   ```dart
   ChangeNotifierProvider<QuizState>
   StreamProvider<ProgressStream>
   ```

2. **Repository Pattern**
   ```dart
   abstract class CareerRepository {
     Future<List<Career>> getAllCareers();
     Future<Career?> getCareerById(String id);
   }
   ```

3. **Use Cases/Interactors**
   ```dart
   class GetCareerRecommendationsUseCase {
     call(QuizResponse input) → Future<List<Career>>;
   }
   ```

4. **Dependency Injection**
   ```dart
   final serviceLocator = GetIt.instance;
   serviceLocator.registerSingleton<RecommendationService>(...);
   ```

---

**Architecture Designed for**: MVP + Hackathon constraints  
**Production Ready**: With minimal changes  
**Scalability**: To backend integration via services
