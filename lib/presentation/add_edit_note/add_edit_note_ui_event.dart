import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_edit_note_ui_event.freezed.dart';

@freezed
class AddEditNoteUiEvent with _$AddEditNoteUiEvent {
  const factory AddEditNoteUiEvent.saveNote() = _SaveNote;
  const factory AddEditNoteUiEvent.showSnackBar(String message) = _ShowSnackBar;
}