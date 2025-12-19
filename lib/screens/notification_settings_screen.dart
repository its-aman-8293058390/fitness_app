import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_provider.dart';
import '../utils/constants.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWorkoutNotificationsSection(notificationProvider),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildGoalProgressNotificationsSection(notificationProvider),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildMealHydrationNotificationsSection(notificationProvider),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildMotivationTipsSection(notificationProvider),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildSystemNotificationsSection(notificationProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutNotificationsSection(NotificationProvider notificationProvider) {
    return Card(
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Workout Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SwitchListTile(
              title: const Text('Workout Reminders'),
              value: notificationProvider.workoutReminders,
              onChanged: (value) {
                notificationProvider.toggleWorkoutReminders();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Daily Training Reminder'),
              value: notificationProvider.dailyTrainingReminder,
              onChanged: (value) {
                notificationProvider.toggleDailyTrainingReminder();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Rest Day Reminder'),
              value: notificationProvider.restDayReminder,
              onChanged: (value) {
                notificationProvider.toggleRestDayReminder();
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalProgressNotificationsSection(NotificationProvider notificationProvider) {
    return Card(
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Goal & Progress Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SwitchListTile(
              title: const Text('Goal Progress Updates'),
              value: notificationProvider.goalProgressUpdates,
              onChanged: (value) {
                notificationProvider.toggleGoalProgressUpdates();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Weekly Progress Summary'),
              value: notificationProvider.weeklyProgressSummary,
              onChanged: (value) {
                notificationProvider.toggleWeeklyProgressSummary();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Weight Change Alerts'),
              value: notificationProvider.weightChangeAlerts,
              onChanged: (value) {
                notificationProvider.toggleWeightChangeAlerts();
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealHydrationNotificationsSection(NotificationProvider notificationProvider) {
    return Card(
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Meal & Hydration Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SwitchListTile(
              title: const Text('Meal Reminder'),
              value: notificationProvider.mealReminder,
              onChanged: (value) {
                notificationProvider.toggleMealReminder();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Water Intake Reminder'),
              value: notificationProvider.waterIntakeReminder,
              onChanged: (value) {
                notificationProvider.toggleWaterIntakeReminder();
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotivationTipsSection(NotificationProvider notificationProvider) {
    return Card(
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Motivation & Tips',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SwitchListTile(
              title: const Text('Daily Motivation Messages'),
              value: notificationProvider.dailyMotivationMessages,
              onChanged: (value) {
                notificationProvider.toggleDailyMotivationMessages();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Fitness Tips & Advice'),
              value: notificationProvider.fitnessTipsAdvice,
              onChanged: (value) {
                notificationProvider.toggleFitnessTipsAdvice();
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemNotificationsSection(NotificationProvider notificationProvider) {
    return Card(
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'System Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SwitchListTile(
              title: const Text('App Updates'),
              value: notificationProvider.appUpdates,
              onChanged: (value) {
                notificationProvider.toggleAppUpdates();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('New Feature Announcements'),
              value: notificationProvider.newFeatureAnnouncements,
              onChanged: (value) {
                notificationProvider.toggleNewFeatureAnnouncements();
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}