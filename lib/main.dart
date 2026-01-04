import "package:darto/darto.dart";

import "config/inject.dart";
import "database/db.dart";
import "router.dart";

void main() async {
  Inject.init();
  await dartonic.sync();
  final app = Darto();

  app.use("/api/v1", rootRouter());

  app.listen(3000, () => print("App Running..."));
}
