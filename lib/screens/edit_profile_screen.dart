import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../utils/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  String? _selectedGender;
  String? _selectedGoal;
  String? _selectedActivityLevel;
  String? _selectedTrainingDays;
  String? _selectedWorkoutType;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _goals = ['Lose Weight', 'Gain Muscle', 'Stay Fit'];
  final List<String> _activityLevels = ['Low', 'Medium', 'High'];
  final List<String> _trainingDays =
      List.generate(7, (index) => '${index + 1}').toList();
  final List<String> _workoutTypes = ['Cardio', 'Strength', 'Yoga', 'Mixed'];

  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    
    _nameController = TextEditingController(text: profileProvider.name);
    _ageController = TextEditingController(text: profileProvider.age?.toString());
    _heightController = TextEditingController(text: profileProvider.height?.toString());
    _weightController = TextEditingController(text: profileProvider.weight?.toString());
    _emailController = TextEditingController(text: profileProvider.email);
    _phoneController = TextEditingController(text: profileProvider.phone);
    
    _selectedGender = profileProvider.gender;
    _selectedGoal = profileProvider.fitnessGoal;
    _selectedActivityLevel = profileProvider.activityLevel;
    _selectedTrainingDays = profileProvider.trainingDays;
    _selectedWorkoutType = profileProvider.preferredWorkoutType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      
      profileProvider.updateProfile(
        name: _nameController.text,
        age: int.tryParse(_ageController.text),
        gender: _selectedGender,
        height: double.tryParse(_heightController.text),
        weight: double.tryParse(_weightController.text),
        fitnessGoal: _selectedGoal,
        activityLevel: _selectedActivityLevel,
        trainingDays: _selectedTrainingDays,
        preferredWorkoutType: _selectedWorkoutType,
        email: _emailController.text,
        phone: _phoneController.text,
      );
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfilePhotoSection(),
                const SizedBox(height: AppDimensions.paddingMedium),
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
                _buildEmailField(),
                const SizedBox(height: AppDimensions.paddingMedium),
                _buildPhoneField(),
                const SizedBox(height: AppDimensions.paddingLarge),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhotoSection() {
    return Center(
      child: Stack(
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
                Icons.edit,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
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

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      enabled: false, // Read-only
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        prefixIcon: const Icon(Icons.email),
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone (Optional)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
        prefixIcon: const Icon(Icons.phone),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          ),
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}