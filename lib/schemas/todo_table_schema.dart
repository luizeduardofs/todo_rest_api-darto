import "package:dartonic/dartonic.dart";

final todoTableSchema = sqliteTable("todos", {
  "id": text().primaryKey(),
  "title": text().notNull(),
  "completed": integer(mode: "boolean").$default(0),
});
