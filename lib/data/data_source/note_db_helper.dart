import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteDBHelper {
  final Database db;

  NoteDBHelper(this.db);

  Future<Note?> getNoteById(int id) async {
    // select * from note where id = 1
    final List<Map<String, dynamic>> maps =
        await db.query('note', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Note>> getNotes() async {
    final List<Map<String, dynamic>> maps = await db.query('note');
    if (maps.isNotEmpty) {
      return maps.map((e) => Note.fromJson(e)).toList();
    }
    return List.empty();
  }

  Future<void> insertNote(Note note) async {
    await db.insert('note', note.toJson());
  }

  Future<void> updateNote(Note note) async {
    await db
        .update('note', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(int id) async {
    await db.delete('note', where: 'id = ?', whereArgs: [id]);
  }
}
