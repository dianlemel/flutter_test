// //https://drift.simonbinder.eu/docs/getting-started/writing_queries/
//
// import 'package:drift/native.dart';
//
// import 'moor_example.dart';
//
// void main() {
//   MyDatabase database;
//
//   setUp(() {
//     database = MyDatabase(NativeDatabase.memory());
//   });
//   tearDown(() async {
//     await database.close();
//   });
// }