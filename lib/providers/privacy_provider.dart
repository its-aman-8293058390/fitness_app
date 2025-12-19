import 'package:flutter/material.dart';

class PrivacyProvider with ChangeNotifier {
  // Account Privacy
  bool _isPrivateAccount = false;
  
  // Profile Visibility
  ProfileVisibility _profileVisibility = ProfileVisibility.public;
  
  // Activity & Progress Privacy
  bool _showWorkoutActivity = true;
  bool _showWeightProgress = true;
  bool _showCaloriesData = true;
  
  // Data & Permissions
  bool _allowActivityTracking = true;
  bool _allowAnalytics = true;
  bool _allowPersonalizedRecommendations = true;

  // Getters
  bool get isPrivateAccount => _isPrivateAccount;
  ProfileVisibility get profileVisibility => _profileVisibility;
  bool get showWorkoutActivity => _showWorkoutActivity;
  bool get showWeightProgress => _showWeightProgress;
  bool get showCaloriesData => _showCaloriesData;
  bool get allowActivityTracking => _allowActivityTracking;
  bool get allowAnalytics => _allowAnalytics;
  bool get allowPersonalizedRecommendations => _allowPersonalizedRecommendations;

  // Setters
  void togglePrivateAccount() {
    _isPrivateAccount = !_isPrivateAccount;
    notifyListeners();
  }

  void setProfileVisibility(ProfileVisibility visibility) {
    _profileVisibility = visibility;
    notifyListeners();
  }

  void toggleShowWorkoutActivity() {
    _showWorkoutActivity = !_showWorkoutActivity;
    notifyListeners();
  }

  void toggleShowWeightProgress() {
    _showWeightProgress = !_showWeightProgress;
    notifyListeners();
  }

  void toggleShowCaloriesData() {
    _showCaloriesData = !_showCaloriesData;
    notifyListeners();
  }

  void toggleAllowActivityTracking() {
    _allowActivityTracking = !_allowActivityTracking;
    notifyListeners();
  }

  void toggleAllowAnalytics() {
    _allowAnalytics = !_allowAnalytics;
    notifyListeners();
  }

  void toggleAllowPersonalizedRecommendations() {
    _allowPersonalizedRecommendations = !_allowPersonalizedRecommendations;
    notifyListeners();
  }

  // Data Management Methods
  void clearLocalFitnessData() {
    // In a real app, this would clear local fitness data
    notifyListeners();
  }

  void resetProfileInformation() {
    // In a real app, this would reset profile information
    notifyListeners();
  }
}

enum ProfileVisibility {
  public,
  friendsOnly,
  onlyMe,
}