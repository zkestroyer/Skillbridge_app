# SkillBridge+ Testing & Verification Guide

## Pre-Submission Testing Checklist

Complete this checklist before submitting the APK.

---

## 1. BUILD & INSTALLATION

### ✓ Compilation
```bash
cd skillbridge_plus
flutter clean
flutter pub get
```
**Expected**: No errors, all dependencies installed

### ✓ Run Debug Build
```bash
flutter run
```
**Expected**: App launches on emulator/device without crash

### ✓ Build Release APK
```bash
flutter build apk --release
```
**Expected**: APK generated at `build/app/outputs/flutter-apk/app-release.apk`

---

## 2. SPLASH SCREEN TEST

### ✓ Launch
Open app from home screen

### ✓ Verify
- [ ] App name "SkillBridge+" displays
- [ ] Subtitle "Quality Education for All" shows
- [ ] SDG 4 mention visible
- [ ] Progress indicator animates
- [ ] Waits 2 seconds

### ✓ Navigation
- [ ] Auto-navigates to onboarding after 2s
- [ ] No manual action needed

**Status**: PASS / FAIL

---

## 3. ONBOARDING SCREEN TEST

### ✓ Content Verification
Scroll through and verify all sections:
- [ ] "Welcome to SkillBridge+" title
- [ ] "The Problem" section with icon
- [ ] "Our Solution" section with icon
- [ ] Key Features list (5 items)
- [ ] SDG 4 alignment section
- [ ] "Get Started" button at bottom

### ✓ Educational Content
- [ ] Problem clearly explains issue
- [ ] Solution explains offline-first approach
- [ ] Features list is accurate
- [ ] SDG 4 text mentions "Goal 4"

### ✓ Button Functionality
- [ ] "Get Started" button is clickable
- [ ] Button navigates to Quiz

**Status**: PASS / FAIL

---

## 4. QUIZ SCREEN TEST

### ✓ Page 1: Interests
- [ ] Title: "What are your interests?"
- [ ] Checkboxes for: Technology, Design, Teaching, Business
- [ ] Can select multiple
- [ ] Progress bar shows ~20%
- [ ] "Next" button enabled
- [ ] "Back" button disabled

**Test**: Select "Technology" + "Design", click Next

### ✓ Page 2: Education Level
- [ ] Title: "What is your education level?"
- [ ] Radio buttons for: School, Intermediate, Undergraduate
- [ ] Only one can be selected at a time
- [ ] Progress bar shows ~40%
- [ ] Back button now enabled

**Test**: Select "School", click Next

### ✓ Page 3: Internet Availability
- [ ] Title: "What is your internet availability?"
- [ ] Radio buttons for: Low, Medium, High
- [ ] Progress bar shows ~60%
- [ ] Previous answers retained

**Test**: Select "Low", click Next

### ✓ Page 4: Financial Constraints
- [ ] Title: "Do you face financial constraints?"
- [ ] Radio buttons for: Yes / No
- [ ] Progress bar shows ~80%

**Test**: Select "Yes", click Next

### ✓ Page 5: Summary
- [ ] Shows all 4 answers in review format
- [ ] Button text: "Get Career Recommendations"
- [ ] Progress bar shows ~100%
- [ ] Can go back to edit

**Test**: Verify answers, click "Get Career Recommendations"

### ✓ Data Validation
```
Test Case: Skip answers
1. Click Next on Page 1 without selecting interests
Expected: Error message "Please complete all questions"
Result: ✓ PASS / ✗ FAIL
```

**Status**: PASS / FAIL

---

## 5. CAREER LIST SCREEN TEST

### ✓ Basic Functionality
- [ ] Page loads without lag
- [ ] Shows "Based on your answers..." message
- [ ] Displays recommendation count (should be 2-4)
- [ ] Career cards visible and readable

### ✓ Career Card Content
Each card should show:
- [ ] Career title (bold, green color)
- [ ] Description (2-line truncated)
- [ ] Interest tags (Chips)
- [ ] Skill count
- [ ] "View Details" link

### ✓ Interaction
- [ ] Tap card → Navigate to Career Detail
- [ ] "Retake Quiz" button at bottom
- [ ] "View Progress" button at bottom

**Test Cases**:
```
Test 1: Verify Recommendations
Quiz: Technology + School + Low Internet
Expected: Low-internet-friendly careers only
Example: Frontend Dev, Backend Dev, Data Analyst (not high-bandwidth careers)

Test 2: Different Quiz Answers
Quiz: Teaching + Intermediate + High Internet + No Constraints
Expected: Different career set (may include online teaching, etc.)

Test 3: Empty State
(Unlikely but if no matches)
Expected: "No careers found" message with retry button
```

**Status**: PASS / FAIL

---

## 6. CAREER DETAIL SCREEN TEST

### ✓ Header Section
- [ ] Career title in green on colored background
- [ ] Career description visible
- [ ] Color scheme consistent with theme

### ✓ Content Sections
1. **Why This Career Fits You**
   - [ ] Section visible
   - [ ] Text explains relevance

2. **Required Skills**
   - [ ] Title: "Required Skills"
   - [ ] List of 3-5 skills with checkmark icons
   - [ ] Each skill on separate line

3. **Education Requirements**
   - [ ] Shows education levels (e.g., "school, intermediate")

4. **Low-Internet Friendly**
   - [ ] Shows correct status (check or info icon)
   - [ ] Text explanation

### ✓ Buttons
- [ ] "View Skill Roadmap" button (green)
- [ ] "Back to Careers" button (outlined)
- [ ] Both are clickable

**Test**: Click "View Skill Roadmap" → Should navigate to Roadmap screen

**Status**: PASS / FAIL

---

## 7. ROADMAP SCREEN TEST

### ✓ Header
- [ ] Title shows career name
- [ ] "Learn step-by-step" text
- [ ] Skill count displayed

### ✓ Skill Organization
- [ ] **Beginner** section header (blue bar)
  - [ ] Beginner skills listed
  - [ ] Checkboxes for each
  - [ ] Skills not marked as complete

- [ ] **Intermediate** section header (orange bar)
  - [ ] Intermediate skills listed
  - [ ] Checkboxes for each

- [ ] **Advanced** section header (red bar)
  - [ ] Advanced skills listed
  - [ ] Checkboxes for each

### ✓ Skill Tile Interaction
For each skill:
- [ ] Title visible
- [ ] Level badge visible (BEGINNER, INTERMEDIATE, ADVANCED)
- [ ] Checkbox unchecked initially

**Test**: Check a skill
- [ ] Checkbox becomes checked
- [ ] Title gets strikethrough
- [ ] Data persists locally

### ✓ Multiple Actions
```
Test 1: Mark 3 skills complete
1. Check: "HTML Basics"
2. Check: "CSS Styling"
3. Check: "UI/UX Design"
Expected: 3 checkmarks, 3 strikethroughs
Result: ✓ PASS / ✗ FAIL

Test 2: Uncheck a skill
1. Click checked skill
Expected: Unchecked, strikethrough removed
Result: ✓ PASS / ✗ FAIL
```

### ✓ Navigation
- [ ] "Back to Career" button works
- [ ] "View Progress" button navigates to Progress screen

**Status**: PASS / FAIL

---

## 8. PROGRESS SCREEN TEST

### ✓ Summary Card (Green)
- [ ] Shows skills completed (e.g., "3")
- [ ] Shows percentage (e.g., "10%")
- [ ] Card has green background

### ✓ Progress Bar
- [ ] Progress bar shows correctly (3/30 = 10%)
- [ ] Label says "Skills Mastery"
- [ ] Percentage matches summary

### ✓ Motivation Message
- [ ] Message changes based on progress
- [ ] Examples:
  - 0%: "Start your learning journey today!"
  - 10%: "Great start! Keep going 🚀"
  - 50%: "You're making good progress! 💪"
  - 90%: "Almost there! Keep it up! 🎯"
  - 100%: "Congratulations! 🏆"

### ✓ Statistics Section
- [ ] Shows "Completed" count (3)
- [ ] Shows "Remaining" count (27)
- [ ] Shows "Total" count (30)
- [ ] Three cards displayed

### ✓ Learning Tips
- [ ] 3 tips visible
- [ ] Tips have icons
- [ ] Text is readable

### ✓ Action Buttons
- [ ] "Explore Careers" button
- [ ] "Reset All Progress" button (outlined)

### ✓ Reset Functionality
```
Test: Reset Progress
1. Click "Reset All Progress"
2. Confirm dialog appears
3. Click "Reset" (or "Cancel" to abort)
Expected: 
  - If Reset: All completed skills cleared
  - Progress returns to 0%
  - Motivation message resets
Result: ✓ PASS / ✗ FAIL
```

**Status**: PASS / FAIL

---

## 9. LOCAL STORAGE TEST

### ✓ Quiz Response Saved
```
Test Procedure:
1. Complete quiz with specific answers
2. Close app completely
3. Reopen app and navigate to Careers
Expected: Same recommendations appear
Result: ✓ PASS / ✗ FAIL
```

### ✓ Completed Skills Saved
```
Test Procedure:
1. Go to Roadmap, mark 5 skills complete
2. Close app completely
3. Reopen app and navigate to Progress
Expected: 
  - 5 skills marked as complete
  - Progress bar shows ~16% (5/30)
  - Skills are still checked in Roadmap
Result: ✓ PASS / ✗ FAIL
```

### ✓ Persistent State
```
Test Procedure:
1. Complete all steps (quiz → careers → roadmap → progress)
2. Force close app
3. Reopen app, navigate back to Roadmap
Expected: All progress and selections preserved
Result: ✓ PASS / ✗ FAIL
```

---

## 10. NAVIGATION TEST

### ✓ Forward Navigation
- [ ] Splash → Onboarding (auto, 2s)
- [ ] Onboarding → Quiz (button click)
- [ ] Quiz → Careers (after submit)
- [ ] Careers → Detail (card tap)
- [ ] Detail → Roadmap (button)
- [ ] Roadmap → Progress (button)

### ✓ Backward Navigation
- [ ] Each screen has working back button
- [ ] Back button doesn't crash app
- [ ] Previous state retained

### ✓ Cross Navigation
- [ ] From Careers: Can go to Progress via "View Progress"
- [ ] From Progress: Can go to Careers via "Explore Careers"
- [ ] Navigation doesn't lose data

**Test**: Complete multi-step navigation without crashing

**Status**: PASS / FAIL

---

## 11. OFFLINE MODE TEST

### ✓ Airplane Mode
```
Test Procedure:
1. Enable Airplane Mode on device
2. Close app
3. Reopen app
Expected: All features work without network
Result: ✓ PASS / ✗ FAIL
```

### ✓ All Features Offline
- [ ] Splash screen works
- [ ] Onboarding loads
- [ ] Quiz works
- [ ] Careers load
- [ ] Details load
- [ ] Roadmap works
- [ ] Progress works

### ✓ No Network Requests
- [ ] Use network monitor (DevTools)
- [ ] No HTTP requests made
- [ ] No API calls
- [ ] Data all from local sources

**Status**: PASS / FAIL

---

## 12. EDGE CASES & ERROR HANDLING

### ✓ Empty Quiz
```
Test: Skip quiz answers
1. Page 1: Don't select anything
2. Click Next
Expected: Error message appears
Result: ✓ PASS / ✗ FAIL
```

### ✓ Missing Career
```
Test: Invalid career ID (should not happen, but)
Expected: Error message or fallback
Result: ✓ PASS / ✗ FAIL
```

### ✓ Data Corruption Recovery
```
Test: Force kill app during save
Expected: App recovers, doesn't crash on reopen
Result: ✓ PASS / ✗ FAIL
```

### ✓ Memory Management
```
Test: Rapidly navigate between screens 10 times
Expected: 
  - No crash
  - No memory leak indicator
  - Smooth performance
Result: ✓ PASS / ✗ FAIL
```

---

## 13. UI/UX TEST

### ✓ Responsiveness
- [ ] All screens adapt to screen size
- [ ] Text is readable on all devices
- [ ] Buttons are easily tappable (48pt minimum)

### ✓ Visual Consistency
- [ ] Color scheme consistent (green theme)
- [ ] Typography consistent
- [ ] Spacing consistent
- [ ] Icons consistent

### ✓ Accessibility
- [ ] Text sizes are readable (14pt+)
- [ ] Contrast is sufficient
- [ ] Touch targets are large enough
- [ ] No flash/animation issues

### ✓ Performance
- [ ] No lag when tapping buttons
- [ ] Smooth transitions
- [ ] Fast screen load times (<500ms)

**Status**: PASS / FAIL

---

## 14. CODE REVIEW VERIFICATION

### ✓ Check File Structure
```bash
ls -la lib/
```
Expected:
- main.dart
- core/ (constants.dart, theme.dart)
- models/ (3 files)
- services/ (3 files)
- screens/ (7 files)
- widgets/ (2 files)

### ✓ Check JSON Data
```bash
cat assets/data/careers.json | head -20
cat assets/data/skills.json | head -20
```
Expected:
- Valid JSON
- 8 careers
- 30 skills
- Proper structure

### ✓ Dependencies Check
```bash
grep -A 5 dependencies pubspec.yaml
```
Expected:
- shared_preferences
- (optional: provider)
- No unnecessary packages

---

## 15. FINAL CHECKLIST

### Functionality
- [ ] All 7 screens work
- [ ] Quiz logic correct
- [ ] Recommendations appear
- [ ] Skills track correctly
- [ ] Progress calculates correctly

### Data
- [ ] Quiz responses saved
- [ ] Skills persist
- [ ] Data survives app restart
- [ ] No data loss on crash

### Offline
- [ ] Works in airplane mode
- [ ] No network requests
- [ ] All features functional offline

### Code Quality
- [ ] No crashes
- [ ] Proper error handling
- [ ] Clean code structure
- [ ] Well-commented

### Documentation
- [ ] README.md complete
- [ ] SETUP_GUIDE.md complete
- [ ] ARCHITECTURE.md complete
- [ ] Code comments present

### SDG 4 Alignment
- [ ] Splash mentions SDG 4
- [ ] Onboarding explains alignment
- [ ] README has SDG section
- [ ] Design supports accessibility

---

## Test Summary Template

```
✓ Splash Screen: PASS
✓ Onboarding: PASS
✓ Quiz: PASS
✓ Recommendations: PASS
✓ Career Details: PASS
✓ Skill Roadmap: PASS
✓ Progress Dashboard: PASS
✓ Local Storage: PASS
✓ Navigation: PASS
✓ Offline Mode: PASS
✓ Error Handling: PASS
✓ UI/UX: PASS
✓ Code Quality: PASS

Overall Status: ✓ READY FOR SUBMISSION
```

---

## Issues & Resolution

If any test fails, follow this process:

1. **Note the issue**: Describe what failed
2. **Reproduce**: Can you repeat the failure?
3. **Check logs**: Look at flutter run output
4. **Review code**: Find the problematic code
5. **Fix**: Make minimal change
6. **Re-test**: Verify fix works
7. **Verify**: Ensure other tests still pass

---

## Sign-Off

- [ ] All tests passed
- [ ] No crashes found
- [ ] Offline mode verified
- [ ] Data persists correctly
- [ ] Navigation works smoothly
- [ ] Code is clean and documented
- [ ] Ready for submission

**Date Tested**: _______________  
**Tester Name**: _______________  
**Status**: ✓ APPROVED FOR SUBMISSION

---

**After completion of all tests → Ready for APK submission!**
