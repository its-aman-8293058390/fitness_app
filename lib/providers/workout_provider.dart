import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/workout.dart';
import '../models/home_data.dart';

class WorkoutProvider with ChangeNotifier {
  List<WorkoutCategory> _categories = [];
  WorkoutDetail? _currentWorkout;
  List<OnboardingItem> _onboardingItems = [];
  HomeData? _homeData;

  List<WorkoutCategory> get categories => _categories;
  WorkoutDetail? get currentWorkout => _currentWorkout;
  List<OnboardingItem> get onboardingItems => _onboardingItems;
  HomeData? get homeData => _homeData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadWorkoutCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString('assets/json/workout_categories.json');
      final data = await json.decode(response);
      _categories = (data as List).map((item) => WorkoutCategory.fromJson(item)).toList();
    } catch (e) {
      print('Error loading workout categories: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadWorkoutDetail() async {
    _isLoading = true;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString('assets/json/workout_detail.json');
      final data = await json.decode(response);
      _currentWorkout = WorkoutDetail.fromJson(data);
    } catch (e) {
      print('Error loading workout detail: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadOnboardingItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString('assets/json/onboarding_data.json');
      final data = await json.decode(response);
      _onboardingItems = (data as List).map((item) => OnboardingItem.fromJson(item)).toList();
    } catch (e) {
      print('Error loading onboarding items: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadHomeData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString('assets/json/home_data.json');
      final data = await json.decode(response);
      _homeData = HomeData.fromJson(data);
    } catch (e) {
      print('Error loading home data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}