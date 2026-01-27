#!/bin/bash
# SkillBridge+ - Pre-Deployment Verification Script

echo "========================================"
echo "SkillBridge+ Pre-Deployment Checklist"
echo "========================================"
echo ""

# Check directory structure
echo "✓ Checking directory structure..."
REQUIRED_DIRS=(
    "lib/core"
    "lib/models"
    "lib/services"
    "lib/screens"
    "lib/widgets"
    "assets/data"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "  ✓ $dir"
    else
        echo "  ✗ MISSING: $dir"
    fi
done

echo ""
echo "✓ Checking critical files..."
REQUIRED_FILES=(
    "lib/main.dart"
    "lib/core/constants.dart"
    "lib/core/theme.dart"
    "lib/models/career.dart"
    "lib/models/skill.dart"
    "lib/models/quiz_response.dart"
    "lib/services/local_storage_service.dart"
    "lib/services/recommendation_service.dart"
    "lib/services/quiz_service.dart"
    "lib/screens/splash_screen.dart"
    "lib/screens/onboarding_screen.dart"
    "lib/screens/quiz_screen.dart"
    "lib/screens/career_list_screen.dart"
    "lib/screens/career_detail_screen.dart"
    "lib/screens/roadmap_screen.dart"
    "lib/screens/progress_screen.dart"
    "lib/widgets/progress_bar.dart"
    "lib/widgets/skill_tile.dart"
    "assets/data/careers.json"
    "assets/data/skills.json"
    "pubspec.yaml"
    "README.md"
    "SETUP_GUIDE.md"
    "ARCHITECTURE.md"
    "JUDGES_GUIDE.md"
    "TESTING_GUIDE.md"
    "IMPLEMENTATION_SUMMARY.md"
    "COMPLETE_SUMMARY.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ✗ MISSING: $file"
    fi
done

echo ""
echo "✓ Checking file sizes..."
echo "  pubspec.yaml: $(wc -l < pubspec.yaml) lines"
echo "  main.dart: $(wc -l < lib/main.dart) lines"
echo "  careers.json: $(wc -l < assets/data/careers.json) lines"
echo "  skills.json: $(wc -l < assets/data/skills.json) lines"

echo ""
echo "✓ Checking pubspec.yaml dependencies..."
if grep -q "shared_preferences" pubspec.yaml; then
    echo "  ✓ shared_preferences included"
else
    echo "  ✗ shared_preferences NOT found"
fi

echo ""
echo "========================================"
echo "✓ PRE-DEPLOYMENT CHECKLIST COMPLETE"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. flutter clean"
echo "2. flutter pub get"
echo "3. flutter run (test on device/emulator)"
echo "4. flutter build apk --release (generate APK)"
echo ""
