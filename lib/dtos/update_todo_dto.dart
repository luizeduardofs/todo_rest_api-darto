class UpdateTodoDto {
  final String? title;
  final bool? completed;

  UpdateTodoDto({this.title, this.completed});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (title != null && title != "") {
      result.addAll({"title": title});
    }

    if (completed != null) {
      result.addAll({"completed": completed});
    }

    return result;
  }

  factory UpdateTodoDto.fromMap(Map<String, dynamic> map) {
    return UpdateTodoDto(
      title: map["title"],
      completed: map["completed"],
    );
  }
}
