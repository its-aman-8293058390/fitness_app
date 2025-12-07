import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/workout_provider.dart';
import '../providers/app_provider.dart';
import '../models/home_data.dart';
import '../utils/constants.dart';
import 'workout_categories_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
      if (workoutProvider.homeData == null) {
        workoutProvider.loadHomeData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final homeData = workoutProvider.homeData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FitTracker'),
        actions: [
          IconButton(
            icon: Icon(appProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              appProvider.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: homeData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGreeting(homeData.user),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    _buildProgressCard(homeData.progress),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    _buildWeightCaloriesRow(homeData.weight, homeData.calories),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    _buildChartSection(),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    _buildMealsSection(homeData.meals),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    _buildNutritionGrid(homeData.nutritionItems),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WorkoutCategoriesScreen()),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.fitness_center),
      ),
    );
  }

  Widget _buildGreeting(User user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[300],
          child: Icon(
            Icons.person,
            size: 30,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello,',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressCard(Progress progress) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            progress.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '${progress.percentage}%',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                width: 80,
                height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress.percentage / 100,
                      strokeWidth: 8,
                      backgroundColor: Colors.white30,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    Text(
                      '${progress.percentage}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeightCaloriesRow(Weight weight, Calories calories) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Weight',
            '${weight.current} ${weight.unit}',
            weight.change > 0 ? '+${weight.change}' : '${weight.change}',
            weight.change > 0 ? Colors.red : Colors.green,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Expanded(
          child: _buildStatCard(
            'Calories',
            '${calories.consumed}/${calories.goal}',
            '-${calories.goal - calories.consumed}',
            Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String change, Color changeColor) {
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
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              change,
              style: TextStyle(
                fontSize: 14,
                color: changeColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection() {
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
              'Weekly Progress',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 30),
                        FlSpot(1, 45),
                        FlSpot(2, 55),
                        FlSpot(3, 75),
                        FlSpot(4, 80),
                        FlSpot(5, 90),
                        FlSpot(6, 75),
                      ],
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealsSection(List<Meal> meals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today\'s Meals',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        ...meals.map((meal) => _buildMealCard(meal)).toList(),
      ],
    );
  }

  Widget _buildMealCard(Meal meal) {
    int totalCalories = 0;
    for (var item in meal.items) {
      totalCalories += item.calories;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  meal.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$totalCalories cal',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (meal.items.isEmpty)
              const Text(
                'No items added',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            else
              Column(
                children: meal.items.map((item) => _buildMealItem(item)).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealItem(MealItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.name),
          Text('${item.calories} cal'),
        ],
      ),
    );
  }

  Widget _buildNutritionGrid(List<NutritionItem> nutritionItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nutrition & Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimensions.paddingSmall,
          mainAxisSpacing: AppDimensions.paddingSmall,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: nutritionItems.map((item) => _buildNutritionItem(item)).toList(),
        ),
      ],
    );
  }

  Widget _buildNutritionItem(NutritionItem item) {
    return Card(
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconData(item.icon),
              size: 30,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String icon) {
    switch (icon) {
      case 'water':
        return Icons.local_drink;
      case 'steps':
        return Icons.directions_walk;
      case 'sleep':
        return Icons.bed;
      case 'heart':
        return Icons.favorite;
      default:
        return Icons.info;
    }
  }
}