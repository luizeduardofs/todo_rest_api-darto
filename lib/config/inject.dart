import "package:injectfy/injectfy.dart";

import "../controllers/todo_controller.dart";
import "../repositories/local/local_todo_repository.dart";
import "../repositories/todo_repository.dart";

class Inject {
  static void init() {
    final injectfy = Injectfy.I;

    injectfy.registerSingleton<TodoRepository>(() => LocalTodoRepository());
    injectfy.registerFactory<TodoController>(() => TodoController(injectfy()));
  }
}
