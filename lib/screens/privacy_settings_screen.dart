import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/privacy_provider.dart';
import '../utils/constants.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final privacyProvider = Provider.of<PrivacyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
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
              _buildAccountPrivacySection(privacyProvider),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildProfileVisibilitySection(privacyProvider),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildActivityPrivacySection(privacyProvider),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildDataPermissionsSection(privacyProvider),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildDataManagementSection(privacyProvider),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildLegalInfoSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountPrivacySection(PrivacyProvider privacyProvider) {
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
              'Account Privacy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SwitchListTile(
              title: const Text('Private Account'),
              subtitle: const Text('Make your profile and activity private'),
              value: privacyProvider.isPrivateAccount,
              onChanged: (value) {
                privacyProvider.togglePrivateAccount();
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileVisibilitySection(PrivacyProvider privacyProvider) {
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
              'Profile Visibility',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            RadioListTile<ProfileVisibility>(
              title: const Text('Public'),
              value: ProfileVisibility.public,
              groupValue: privacyProvider.profileVisibility,
              onChanged: (value) {
                if (value != null) {
                  privacyProvider.setProfileVisibility(value);
                }
              },
            ),
            RadioListTile<ProfileVisibility>(
              title: const Text('Friends Only'),
              value: ProfileVisibility.friendsOnly,
              groupValue: privacyProvider.profileVisibility,
              onChanged: (value) {
                if (value != null) {
                  privacyProvider.setProfileVisibility(value);
                }
              },
            ),
            RadioListTile<ProfileVisibility>(
              title: const Text('Only Me'),
              value: ProfileVisibility.onlyMe,
              groupValue: privacyProvider.profileVisibility,
              onChanged: (value) {
                if (value != null) {
                  privacyProvider.setProfileVisibility(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityPrivacySection(PrivacyProvider privacyProvider) {
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
              'Activity & Progress Privacy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SwitchListTile(
              title: const Text('Show Workout Activity'),
              value: privacyProvider.showWorkoutActivity,
              onChanged: (value) {
                privacyProvider.toggleShowWorkoutActivity();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Show Weight Progress'),
              value: privacyProvider.showWeightProgress,
              onChanged: (value) {
                privacyProvider.toggleShowWeightProgress();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Show Calories Data'),
              value: privacyProvider.showCaloriesData,
              onChanged: (value) {
                privacyProvider.toggleShowCaloriesData();
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataPermissionsSection(PrivacyProvider privacyProvider) {
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
              'Data & Permissions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SwitchListTile(
              title: const Text('Allow Activity Tracking'),
              subtitle: const Text('Track your workouts and activities'),
              value: privacyProvider.allowActivityTracking,
              onChanged: (value) {
                privacyProvider.toggleAllowActivityTracking();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Allow Analytics'),
              subtitle: const Text('Help us improve the app (UI-only)'),
              value: privacyProvider.allowAnalytics,
              onChanged: (value) {
                privacyProvider.toggleAllowAnalytics();
              },
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Allow Personalized Recommendations'),
              subtitle: const Text('Get workout suggestions based on your activity'),
              value: privacyProvider.allowPersonalizedRecommendations,
              onChanged: (value) {
                privacyProvider.toggleAllowPersonalizedRecommendations();
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataManagementSection(PrivacyProvider privacyProvider) {
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
              'Data Management',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(
                    context,
                    'Clear Local Fitness Data',
                    'Are you sure you want to clear all your local fitness data? This action cannot be undone.',
                    () {
                      privacyProvider.clearLocalFitnessData();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Local fitness data cleared'),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
                  ),
                ),
                child: const Text('Clear Local Fitness Data'),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(
                    context,
                    'Reset Profile Information',
                    'Are you sure you want to reset your profile information?',
                    () {
                      privacyProvider.resetProfileInformation();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile information reset'),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
                  ),
                ),
                child: const Text('Reset Profile Information'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalInfoSection() {
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
              'Legal & Info',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showStaticInfoScreen(context, 'Privacy Policy');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
                  ),
                ),
                child: const Text('Privacy Policy'),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showStaticInfoScreen(context, 'Terms & Conditions');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
                  ),
                ),
                child: const Text('Terms & Conditions'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: onConfirm,
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showStaticInfoScreen(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(title),
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
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n'
                    'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n'
                    'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.\n\n'
                    'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.\n\n'
                    'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}