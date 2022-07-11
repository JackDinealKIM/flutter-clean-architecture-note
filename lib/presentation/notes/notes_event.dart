
import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes_event.freezed.dart';

@freezed
abstract class NotesEvent with _$NotesEvent {
  const factory NotesEvent.loadNotes() = LoadNotes;
  const factory NotesEvent.deleteNotes(Note note) = DeleteNotes;
  const factory NotesEvent.restoreNote() = RestoreNote;

}