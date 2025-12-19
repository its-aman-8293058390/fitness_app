import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  // Workout Notifications
  bool _workoutReminders = true;
  bool _dailyTrainingReminder = true;
  bool _restDayReminder = true;
  
  // Goal & Progress Notifications
  bool _goalProgressUpdates = true;
  bool _weeklyProgressSummary = true;
  bool _weightChangeAlerts = true;
  
  // Meal & Hydration Notifications
  bool _mealReminder = true;
  bool _waterIntakeReminder = true;
  
  // Motivation & Tips
  bool _dailyMotivationMessages = true;
  bool _fitnessTipsAdvice = true;
  
  // System Notifications
  bool _appUpdates = true;
  bool _newFeatureAnnouncements = true;

  // Getters
  bool get workoutReminders => _workoutReminders;
  bool get dailyTrainingReminder => _dailyTrainingReminder;
  bool get restDayReminder => _restDayReminder;
  bool get goalProgressUpdates => _goalProgressUpdates;
  bool get weeklyProgressSummary => _weeklyProgressSummary;
  bool get weightChangeAlerts => _weightChangeAlerts;
  bool get mealReminder => _mealReminder;
  bool get waterIntakeReminder => _waterIntakeReminder;
  bool get dailyMotivationMessages => _dailyMotivationMessages;
  bool get fitnessTipsAdvice => _fitnessTipsAdvice;
  bool get appUpdates => _appUpdates;
  bool get newFeatureAnnouncements => _newFeatureAnnouncements;

  // Setters
  void toggleWorkoutReminders() {
    _workoutReminders = !_workoutReminders;
    notifyListeners();
  }

  void toggleDailyTrainingReminder() {
    _dailyTrainingReminder = !_dailyTrainingReminder;
    notifyListeners();
  }

  void toggleRestDayReminder() {
    _restDayReminder = !_restDayReminder;
    notifyListeners();
  }

  void toggleGoalProgressUpdates() {
    _goalProgressUpdates = !_goalProgressUpdates;
    notifyListeners();
  }

  void toggleWeeklyProgressSummary() {
    _weeklyProgressSummary = !_weeklyProgressSummary;
    notifyListeners();
  }

  void toggleWeightChangeAlerts() {
    _weightChangeAlerts = !_weightChangeAlerts;
    notifyListeners();
  }

  void toggleMealReminder() {
    _mealReminder = !_mealReminder;
    notifyListeners();
  }

  void toggleWaterIntakeReminder() {
    _waterIntakeReminder = !_waterIntakeReminder;
    notifyListeners();
  }

  void toggleDailyMotivationMessages() {
    _dailyMotivationMessages = !_dailyMotivationMessages;
    notifyListeners();
  }

  void toggleFitnessTipsAdvice() {
    _fitnessTipsAdvice = !_fitnessTipsAdvice;
    notifyListeners();
  }

  void toggleAppUpdates() {
    _appUpdates = !_appUpdates;
    notifyListeners();
  }

  void toggleNewFeatureAnnouncements() {
    _newFeatureAnnouncements = !_newFeatureAnnouncements;
    notifyListeners();
  }
}