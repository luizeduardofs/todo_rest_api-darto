import "dart:io";

import "package:darto/darto.dart";
import "package:dartonic/dartonic.dart";
import "package:zard/zard.dart";

import "../database/db.dart";

class TodoController {
  Future<void> getAll(Request req, Response res) async {
    final todos = await db.select().from("todos");

    return res.status(HttpStatus.ok).json(todos);
  }

  Future<void> create(Request req, Response res) async {
    final bodySchema = z.map({
      "title": z.string().min(3).max(100),
      "completed": z.bool().optional(),
    });

    try {
      final body = bodySchema.parse(await req.body);

      await db.insert("todos").values(body);

      return res.status(HttpStatus.created).end();
    } on ZardError catch (e) {
      return res.status(HttpStatus.badRequest).json({"error": e.format()});
    }
  }

  Future<void> update(Request req, Response res) async {
    final paramSchema = z.coerce.int();

    final bodySchema = z.map({
      "title": z.string().min(3).max(100).optional(),
      "completed": z.bool().optional(),
    });

    try {
      final id = paramSchema.parse(req.param["id"]);
      final body = bodySchema.parse(await req.body);

      final todoExists = await db
          .select()
          .from("todos")
          .where(eq("todos.id", id));

      if (todoExists.isEmpty) {
        return res.status(HttpStatus.notFound).json({
          "error": "Todo not found",
        });
      }

      final data = await db
          .update("todos")
          .set(body)
          .where(eq("todos.id", id))
          .returning();

      return res.status(HttpStatus.ok).json(data);
    } on ZardError catch (e) {
      return res.status(HttpStatus.badRequest).json({"error": e.format()});
    }
  }

  Future<void> remove(Request req, Response res) async {
    final paramSchema = z.coerce.int();

    try {
      final id = paramSchema.parse(req.param["id"]);

      final todoExists = await db
          .select()
          .from("todos")
          .where(eq("todos.id", id));

      if (todoExists.isEmpty) {
        return res.status(HttpStatus.notFound).json({
          "error": "Todo not found",
        });
      }

      await db.delete("todos").where(eq("todos.id", id));

      return res.status(HttpStatus.noContent).end();
    } on ZardError catch (e) {
      return res.status(HttpStatus.badRequest).json({"error": e.format()});
    }
  }
}
