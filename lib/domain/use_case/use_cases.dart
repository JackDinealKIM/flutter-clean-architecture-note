import 'package:clean_architecture_note/domain/use_case/add_note_use_case.dart';
import 'package:clean_architecture_note/domain/use_case/delete_note_use_case.dart';
import 'package:clean_architecture_note/domain/use_case/get_note_use_case.dart';
import 'package:clean_architecture_note/domain/use_case/get_notes_use_case.dart';
import 'package:clean_architecture_note/domain/use_case/update_note_use_case.dart';

class UseCases {
  final AddNoteUseCase addNote;
  final DeleteNoteUseCase deleteNote;
  final GetNoteUseCase getNote;
  final GetNotesUseCase getNotes;
  final UpdateNoteUseCase updateNote;

  UseCases(
    this.addNote,
    this.deleteNote,
    this.getNote,
    this.getNotes,
    this.updateNote,
  );
}
