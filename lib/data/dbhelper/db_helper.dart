import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'posts.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
    CREATE TABLE Posts(
    id integer primary key ,
    title text not null,
    body text not null
   ) ;
    ''');
      },
    );
  }
}
