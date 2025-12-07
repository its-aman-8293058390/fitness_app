import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import '../models/workout.dart';
import '../utils/constants.dart';
import 'workout_detail_screen.dart';

class WorkoutCategoriesScreen extends StatefulWidget {
  const WorkoutCategoriesScreen({super.key});

  @override
  State<WorkoutCategoriesScreen> createState() => _WorkoutCategoriesScreenState();
}

class _WorkoutCategoriesScreenState extends State<WorkoutCategoriesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
      if (workoutProvider.categories.isEmpty) {
        workoutProvider.loadWorkoutCategories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final categories = workoutProvider.categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Categories'),
      ),
      body: workoutProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppDimensions.paddingSmall,
                  mainAxisSpacing: AppDimensions.paddingSmall,
                  childAspectRatio: 0.85,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(categories[index]);
                },
              ),
            ),
    );
  }

  Widget _buildCategoryCard(WorkoutCategory category) {
    return Card(
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to workout detail screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WorkoutDetailScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: _parseColor(category.color),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(AppDimensions.borderRadiusMedium)),
                ),
                child: Center(
                  child: Icon(
                    Icons.fitness_center,
                    size: 50,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _parseColor(String colorString) {
    // Remove the '#' and parse the hex color
    final hexCode = colorString.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}