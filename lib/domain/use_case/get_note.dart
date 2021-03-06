
import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/domain/repository/note_repository.dart';

class GetNote {
  final NoteRepository repository;

  GetNote(this.repository);

  Future<Note?> call(int id) async {
    return await repository.getNoteById(id);
  }
}