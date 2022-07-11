import 'package:clean_architecture_note/data/data_source/note_db.dart';
import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/domain/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final NoteDB db;

  NoteRepositoryImpl(this.db);

  @override
  Future<void> deleteNote(int id) async {
    await db.deleteNote(id);
  }

  @override
  Future<Note?> getNoteById(int id) async {
    return await db.getNoteById(id);
  }

  @override
  Future<List<Note>?> getNotes() async {
    return await db.getNotes();
  }

  @override
  Future<void> insertNote(Note note) async {
    await db.insertNote(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await db.updateNote(note);
  }
}
