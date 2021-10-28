import 'package:drift/drift.dart';

// assuming that your file is called filename.dart. This will give an error at first,
// but it's needed for drift to know about the generated code
part 'moor_example.g.dart';

// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().nullable()();
}

// This will make drift generate a class called "Category" to represent a row in this table.
// By default, "Categorie" would have been used because it only strips away the trailing "s"
// in the table name.
@DataClassName("Category")
class Categories extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [Todos, Categories])
class MyDatabase extends _$MyDatabase {
  MyDatabase(QueryExecutor e) : super(e);

  // the schemaVersion getter and the constructor from the previous page
  // have been omitted.

  // loads all todo entries
  Future<List<Todo>> get allTodoEntries => select(todos).get();

  // watches all todo entries in a given category. The stream will automatically
  // emit new items whenever the underlying data changes.
  Stream<List<Todo>> watchEntriesInCategory(Category c) {
    return (select(todos)..where((t) => t.category.equals(c.id))).watch();
  }

  Stream<Todo> entryById(int id) {
    return (select(todos)..where((t) => t.id.equals(id))).watchSingle();
  }

  Future<int> addTodo(TodosCompanion entry) {
    return into(todos).insert(entry);
  }

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}