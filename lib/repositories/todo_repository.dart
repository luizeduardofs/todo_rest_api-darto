import "../dtos/create_todo_dto.dart";
import "../dtos/update_todo_dto.dart";
import "../models/todo_model.dart";

abstract interface class TodoRepository {
  Future<List<TodoModel>> getAllTodos();
  Future<TodoModel?> getTodoById(String id);
  Future<void> createTodo(CreateTodoDto todo);
  Future<TodoModel> updateTodo(String id, UpdateTodoDto todo);
  Future<void> deleteTodo(String id);
}
