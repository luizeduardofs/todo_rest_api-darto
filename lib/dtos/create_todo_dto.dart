import "package:uuid/uuid.dart";

class CreateTodoDto {
  final String title;
  final bool? completed;

  CreateTodoDto({required this.title, this.completed = false});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({"id": Uuid().v4()});
    result.addAll({"title": title});
    result.addAll({"completed": completed});

    return result;
  }

  factory CreateTodoDto.fromMap(Map<String, dynamic> map) {
    return CreateTodoDto(
      title: map["title"],
      completed: map["completed"],
    );
  }
}
