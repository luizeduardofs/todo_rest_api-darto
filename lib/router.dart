import "package:darto/darto.dart";
import "package:injectfy/injectfy.dart";

import "controllers/todo_controller.dart";
import "middlewares/logger_middleware.dart";

Router rootRouter() {
  final router = Router();
  final todoController = Injectfy.get<TodoController>();

  router.get("/todos", loggerMiddleware, todoController.getAll);
  router.post("/todos", loggerMiddleware, todoController.create);
  router.put("/todos/:id", loggerMiddleware, todoController.update);
  router.delete("/todos/:id", loggerMiddleware, todoController.remove);

  return router;
}
