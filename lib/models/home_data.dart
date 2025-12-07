class HomeData {
  final User user;
  final Progress progress;
  final Weight weight;
  final Calories calories;
  final List<Meal> meals;
  final List<NutritionItem> nutritionItems;

  HomeData({
    required this.user,
    required this.progress,
    required this.weight,
    required this.calories,
    required this.meals,
    required this.nutritionItems,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    var mealsList = json['meals'] as List;
    List<Meal> meals = mealsList.map((meal) => Meal.fromJson(meal)).toList();

    var nutritionItemsList = json['nutritionItems'] as List;
    List<NutritionItem> nutritionItems =
        nutritionItemsList.map((item) => NutritionItem.fromJson(item)).toList();

    return HomeData(
      user: User.fromJson(json['user']),
      progress: Progress.fromJson(json['progress']),
      weight: Weight.fromJson(json['weight']),
      calories: Calories.fromJson(json['calories']),
      meals: meals,
      nutritionItems: nutritionItems,
    );
  }
}

class User {
  final String name;
  final String profilePicture;

  User({
    required this.name,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      profilePicture: json['profilePicture'],
    );
  }
}

class Progress {
  final int percentage;
  final String title;

  Progress({
    required this.percentage,
    required this.title,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      percentage: json['percentage'],
      title: json['title'],
    );
  }
}

class Weight {
  final double current;
  final String unit;
  final double change;

  Weight({
    required this.current,
    required this.unit,
    required this.change,
  });

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      current: json['current'].toDouble(),
      unit: json['unit'],
      change: json['change'].toDouble(),
    );
  }
}

class Calories {
  final int consumed;
  final int burned;
  final int goal;

  Calories({
    required this.consumed,
    required this.burned,
    required this.goal,
  });

  factory Calories.fromJson(Map<String, dynamic> json) {
    return Calories(
      consumed: json['consumed'],
      burned: json['burned'],
      goal: json['goal'],
    );
  }
}

class Meal {
  final int id;
  final String name;
  final List<MealItem> items;

  Meal({
    required this.id,
    required this.name,
    required this.items,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<MealItem> items = itemsList.map((item) => MealItem.fromJson(item)).toList();

    return Meal(
      id: json['id'],
      name: json['name'],
      items: items,
    );
  }
}

class MealItem {
  final int id;
  final String name;
  final int calories;

  MealItem({
    required this.id,
    required this.name,
    required this.calories,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      id: json['id'],
      name: json['name'],
      calories: json['calories'],
    );
  }
}

class NutritionItem {
  final int id;
  final String name;
  final String value;
  final String icon;

  NutritionItem({
    required this.id,
    required this.name,
    required this.value,
    required this.icon,
  });

  factory NutritionItem.fromJson(Map<String, dynamic> json) {
    return NutritionItem(
      id: json['id'],
      name: json['name'],
      value: json['value'],
      icon: json['icon'],
    );
  }
}