import "package:dartonic/dartonic.dart";

final todoTableSchema = sqliteTable("todos", {
  "id": integer().primaryKey(autoIncrement: true),
  "title": text().notNull(),
  "completed": integer(mode: "boolean").$default(0),
});
