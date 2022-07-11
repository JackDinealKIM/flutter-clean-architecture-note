import 'package:clean_architecture_note/data/data_source/note_db_helper.dart';
import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('db test', () async {
    // Init ffi loader if needed.
    sqfliteFfiInit();

    var databaseFactory = databaseFactoryFfi;
    final db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute('''
      CREATE TABLE note (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          content TEXT,
          color INTEGER,
          timestamp INTEGER
      )
      ''');

    final noteDBHelper = NoteDBHelper(db);

    await noteDBHelper.insertNote(
        const Note(title: 'test', content: 'test', color: 1, timestamp: 1));

    expect((await noteDBHelper.getNotes()).length, 1);

    Note note = (await noteDBHelper.getNoteById(1))!;
    expect(note.id, 1);

    await noteDBHelper.updateNote(note.copyWith(title: 'change'));

    note = (await noteDBHelper.getNoteById(1))!;
    expect(note.title, 'change');

    await noteDBHelper.deleteNote(1);
    expect((await noteDBHelper.getNotes()).length, 0);

    await db.close();
  });
}
