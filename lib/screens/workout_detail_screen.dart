import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import '../models/workout.dart';
import '../utils/constants.dart';
import 'start_workout_screen.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({super.key});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
      if (workoutProvider.currentWorkout == null) {
        workoutProvider.loadWorkoutDetail();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final workout = workoutProvider.currentWorkout;

    return Scaffold(
      appBar: AppBar(
        title: Text(workout?.name ?? 'Workout Details'),
      ),
      body: workoutProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : workout == null
              ? const Center(child: Text('No workout data available'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWorkoutHeader(workout),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        _buildWorkoutInfo(workout),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        _buildStepsList(workout.steps),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: workout != null
          ? Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartWorkoutScreen(workout: workout),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
                  ),
                ),
                child: const Text(
                  'Start Workout',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildWorkoutHeader(WorkoutDetail workout) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Center(
        child: Icon(
          Icons.fitness_center,
          size: 80,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildWorkoutInfo(WorkoutDetail workout) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildInfoItem('Duration', workout.duration),
        _buildInfoItem('Calories', '${workout.calories} cal'),
        _buildInfoItem('Difficulty', workout.difficulty),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStepsList(List<WorkoutStep> steps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Steps',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: steps.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final step = steps[index];
            return ListTile(
              leading: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${step.id}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                step.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(step.description),
              trailing: Text(step.duration),
            );
          },
        ),
      ],
    );
  }
}