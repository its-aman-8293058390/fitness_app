import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String _name = '';
  int? _age;
  String? _gender;
  double? _height;
  double? _weight;
  String? _fitnessGoal;
  String? _activityLevel;
  String? _trainingDays;
  String? _preferredWorkoutType;
  String _email = '';
  String? _phone;

  // Getters
  String get name => _name;
  int? get age => _age;
  String? get gender => _gender;
  double? get height => _height;
  double? get weight => _weight;
  String? get fitnessGoal => _fitnessGoal;
  String? get activityLevel => _activityLevel;
  String? get trainingDays => _trainingDays;
  String? get preferredWorkoutType => _preferredWorkoutType;
  String get email => _email;
  String? get phone => _phone;

  // Update profile method
  void updateProfile({
    required String name,
    int? age,
    String? gender,
    double? height,
    double? weight,
    String? fitnessGoal,
    String? activityLevel,
    String? trainingDays,
    String? preferredWorkoutType,
    required String email,
    String? phone,
  }) {
    _name = name;
    _age = age;
    _gender = gender;
    _height = height;
    _weight = weight;
    _fitnessGoal = fitnessGoal;
    _activityLevel = activityLevel;
    _trainingDays = trainingDays;
    _preferredWorkoutType = preferredWorkoutType;
    _email = email;
    _phone = phone;
    
    notifyListeners();
  }
}