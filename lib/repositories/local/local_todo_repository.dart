import "package:dartonic/dartonic.dart";

import "../../database/db.dart";
import "../../dtos/create_todo_dto.dart";
import "../../dtos/update_todo_dto.dart";
import "../../models/todo_model.dart";
import "../todo_repository.dart";

class LocalTodoRepository implements TodoRepository {
  @override
  Future<void> createTodo(CreateTodoDto todo) async {
    await db.insert("todos").values(todo.toMap());
  }

  @override
  Future<void> deleteTodo(String id) async {
    await db.delete("todos").where(eq("todos.id", id));
  }

  @override
  Future<List<TodoModel>> getAllTodos() async {
    final result = await db.select().from("todos") as List;

    return result.map((row) => TodoModel.fromMap(row)).toList();
  }

  @override
  Future<TodoModel?> getTodoById(String id) async {
    final result =
        await db.select().from("todos").where(eq("todos.id", id)) as List;

    if (result.isEmpty) return null;

    return TodoModel.fromMap(result.first);
  }

  @override
  Future<TodoModel> updateTodo(String id, UpdateTodoDto todo) async {
    final result = await db
        .update("todos")
        .set(todo.toMap())
        .where(eq("todos.id", id))
        .returning();

    return TodoModel.fromMap(result.first);
  }
}
