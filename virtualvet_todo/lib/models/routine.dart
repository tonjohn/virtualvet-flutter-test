class RoutineModel {
  final String id;
  final String title;
  final String description;
  final int reminder;
  final bool isCompleted;
  final List<String> tags;

  const RoutineModel({
    this.id,
    this.title,
    this.description,
    this.reminder,
    this.isCompleted = false,
    this.tags,
  });

  factory RoutineModel.fromMap(Map data) {
    return RoutineModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      isCompleted: data['is_completed'],
      reminder: data['reminder'],
      tags: data['tags'],
    );
  }

  Map toMap() {
    return {
      'id': this.id,
      "title": this.title,
      "description": this.description,
      "reminder": this.reminder,
      "tags": this.tags,
      'is_completed': this.isCompleted,
    };
  }
}

// dummy list of routines
List<RoutineModel> routineList = [
  RoutineModel(title: "WALK", description: ""),
  RoutineModel(title: "FOOD", description: ""),
  RoutineModel(title: "PUMPKIN", description: ""),
  RoutineModel(title: "FLEA MEDS", description: ""),
  RoutineModel(title: "BRUSH TEETH", description: ""),
];

List<String> tags = [
  "MEDICATION",
  "FOOD",
  "HYGIENE",
  "EXERCISE",
  "TRAINING",
  "VACCINES",
];
