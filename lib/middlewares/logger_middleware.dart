import "package:darto/darto.dart";

void loggerMiddleware(Request req, Response res, NextFunction next) {
  print("${res.status} - ${req.method} - ${DateTime.now()}");
  next();
}
