import "dart:io";

import "package:darto/darto.dart";
import "package:zard/zard.dart";

import "../dtos/create_todo_dto.dart";
import "../dtos/update_todo_dto.dart";
import "../repositories/todo_repository.dart";

class TodoController {
  final TodoRepository _repository;

  TodoController(this._repository);

  Future<void> getAll(Request req, Response res) async {
    final todos = await _repository.getAllTodos();

    return res.status(HttpStatus.ok).json(todos.map((e) => e.toMap()).toList());
  }

  Future<void> create(Request req, Response res) async {
    final bodySchema = z.map({
      "title": z.string().min(3).max(100),
      "completed": z.bool().optional(),
    });

    try {
      final body = bodySchema.parse(await req.body);

      await _repository.createTodo(CreateTodoDto.fromMap(body));

      return res.status(HttpStatus.created).end();
    } on ZardError catch (e) {
      return res.status(HttpStatus.badRequest).json({"error": e.format()});
    }
  }

  Future<void> update(Request req, Response res) async {
    final paramSchema = z.string().uuid();

    final bodySchema = z.map({
      "title": z.string().min(3).max(100).optional(),
      "completed": z.bool().optional(),
    });

    try {
      final id = paramSchema.parse(req.param["id"]);
      final body = bodySchema.parse(await req.body);

      final todoExists = await _repository.getTodoById(id);

      if (todoExists == null) {
        return res.status(HttpStatus.notFound).json({
          "error": "Todo not found",
        });
      }

      final data = await _repository.updateTodo(
        id,
        UpdateTodoDto.fromMap(body),
      );

      return res.status(HttpStatus.ok).json(data.toMap());
    } on ZardError catch (e) {
      return res.status(HttpStatus.badRequest).json({"error": e.format()});
    }
  }

  Future<void> remove(Request req, Response res) async {
    final paramSchema = z.string().uuid();

    try {
      final id = paramSchema.parse(req.param["id"]);

      final todoExists = await _repository.getTodoById(id);

      if (todoExists == null) {
        return res.status(HttpStatus.notFound).json({
          "error": "Todo not found",
        });
      }

      await _repository.deleteTodo(id);

      return res.status(HttpStatus.noContent).end();
    } on ZardError catch (e) {
      return res.status(HttpStatus.badRequest).json({"error": e.format()});
    }
  }
}
