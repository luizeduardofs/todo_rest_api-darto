class TodoModel {
  final String id;
  final String title;
  final bool completed;

  TodoModel({required this.id, required this.title, required this.completed});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({"id": id});
    result.addAll({"title": title});
    result.addAll({"completed": completed});

    return result;
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map["id"] ?? "",
      title: map["title"] ?? "",
      completed: map["completed"] ?? false,
    );
  }
}
