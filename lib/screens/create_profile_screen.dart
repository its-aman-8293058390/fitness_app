import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../screens/home_screen.dart';
import '../utils/constants.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  String? _selectedGender;
  String? _selectedGoal;
  String? _selectedActivityLevel;
  String? _selectedTrainingDays;
  String? _selectedWorkoutType;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _goals = ['Lose Weight', 'Build Muscle', 'Get Fit'];
  final List<String> _activityLevels = ['Low', 'Medium', 'High'];
  final List<String> _trainingDays =
      List.generate(7, (index) => '${index + 1}').toList();
  final List<String> _workoutTypes = ['Cardio', 'Strength', 'Yoga', 'Mixed'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _saveProfileAndNavigate() {
    if (_formKey.currentState!.validate()) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);

      profileProvider.updateProfile(
        name: _nameController.text,
        age: int.tryParse(_ageController.text) ?? 0,
        gender: _selectedGender,
        height: double.tryParse(_heightController.text) ?? 0.0,
        weight: double.tryParse(_weightController.text) ?? 0.0,
        fitnessGoal: _selectedGoal,
        activityLevel: _selectedActivityLevel,
        trainingDays: _selectedTrainingDays,
        preferredWorkoutType: _selectedWorkoutType,
        email: '${_nameController.text.toLowerCase().replaceAll(' ', '.')}@fittracker.com', // Generate email
        phone: '', // Empty phone by default
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: AppDimensions.paddingLarge),
                _buildNameField(),
                const SizedBox(height: AppDimensions.paddingMedium),
                _buildAgeField(),
                const SizedBox(height: AppDimensions.paddingMedium),
                _buildGenderDropdown(),
                const SizedBox(height: AppDimensions.paddingMedium),
                _buildHeightWeightRow(),
                const SizedBox(height: AppDimensions.paddingMedium),
                _buildFitnessGoalDropdown(),
                const SizedBox(height: AppDimensions.paddingMedium),
                _buildActivityLevelDropdown(),
                const SizedBox(height: AppDimensions.paddingMedium),
                _buildTrainingDaysDropdown(),
                const SizedBox(height: AppDimensions.paddingMedium),
                _buildWorkoutTypeDropdown(),
                const SizedBox(height: AppDimensions.paddingMedium),
                _buildProfilePhotoSection(),
                const SizedBox(height: AppDimensions.paddingLarge),
                _buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Icon(
          Icons.fitness_center,
          size: 80,
          color: AppColors.primary,
        ),
        const SizedBox(height: 16),
        const Text(
          'Tell Us About Yourself',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Help us personalize your fitness experience',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Full Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        return null;
      },
    );
  }

  Widget _buildAgeField() {
    return TextFormField(
      controller: _ageController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Age',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        prefixIcon: const Icon(Icons.calendar_today),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your age';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        prefixIcon: const Icon(Icons.accessibility),
      ),
      items: _genders.map((gender) {
        return DropdownMenuItem(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }

  Widget _buildHeightWeightRow() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Height (cm)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
              ),
              prefixIcon: const Icon(Icons.height),
            ),
            validator: (value) {
              if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Expanded(
          child: TextFormField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Weight (kg)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
              ),
              prefixIcon: const Icon(Icons.monitor_weight),
            ),
            validator: (value) {
              if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFitnessGoalDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGoal,
      decoration: InputDecoration(
        labelText: 'Fitness Goal',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        prefixIcon: const Icon(Icons.flag),
      ),
      items: _goals.map((goal) {
        return DropdownMenuItem(
          value: goal,
          child: Text(goal),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGoal = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your fitness goal';
        }
        return null;
      },
    );
  }

  Widget _buildActivityLevelDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedActivityLevel,
      decoration: InputDecoration(
        labelText: 'Activity Level',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        prefixIcon: const Icon(Icons.directions_run),
      ),
      items: _activityLevels.map((level) {
        return DropdownMenuItem(
          value: level,
          child: Text(level),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedActivityLevel = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your activity level';
        }
        return null;
      },
    );
  }

  Widget _buildTrainingDaysDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedTrainingDays,
      decoration: InputDecoration(
        labelText: 'Training Days Per Week',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        prefixIcon: const Icon(Icons.calendar_view_week),
      ),
      items: _trainingDays.map((days) {
        return DropdownMenuItem(
          value: days,
          child: Text('$days Day${days == '1' ? '' : 's'}'),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedTrainingDays = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select training days';
        }
        return null;
      },
    );
  }

  Widget _buildWorkoutTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedWorkoutType,
      decoration: InputDecoration(
        labelText: 'Preferred Workout Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        prefixIcon: const Icon(Icons.fitness_center),
      ),
      items: _workoutTypes.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedWorkoutType = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your preferred workout type';
        }
        return null;
      },
    );
  }

  Widget _buildProfilePhotoSection() {
    return Center(
      child: Column(
        children: [
          const Text(
            'Profile Photo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap to choose photo',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveProfileAndNavigate,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}