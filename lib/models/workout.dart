class WorkoutCategory {
  final int id;
  final String name;
  final String description;
  final String image;
  final String color;

  WorkoutCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.color,
  });

  factory WorkoutCategory.fromJson(Map<String, dynamic> json) {
    return WorkoutCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      color: json['color'],
    );
  }
}

class WorkoutDetail {
  final int id;
  final String name;
  final String description;
  final String image;
  final String duration;
  final int calories;
  final String difficulty;
  final List<WorkoutStep> steps;

  WorkoutDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.duration,
    required this.calories,
    required this.difficulty,
    required this.steps,
  });

  factory WorkoutDetail.fromJson(Map<String, dynamic> json) {
    var stepsList = json['steps'] as List;
    List<WorkoutStep> steps = stepsList.map((step) => WorkoutStep.fromJson(step)).toList();

    return WorkoutDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      duration: json['duration'],
      calories: json['calories'],
      difficulty: json['difficulty'],
      steps: steps,
    );
  }
}

class WorkoutStep {
  final int id;
  final String title;
  final String duration;
  final String description;

  WorkoutStep({
    required this.id,
    required this.title,
    required this.duration,
    required this.description,
  });

  factory WorkoutStep.fromJson(Map<String, dynamic> json) {
    return WorkoutStep(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      description: json['description'],
    );
  }
}

class OnboardingItem {
  final int id;
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory OnboardingItem.fromJson(Map<String, dynamic> json) {
    return OnboardingItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}