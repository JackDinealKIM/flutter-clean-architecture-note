
import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/domain/repository/note_repository.dart';

class UpdateNoteUseCase {
  final NoteRepository repository;

  UpdateNoteUseCase(this.repository);

  Future<void> call(Note note) async {
    await repository.updateNote(note);
  }
}