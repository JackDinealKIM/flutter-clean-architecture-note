import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_state.freezed.dart';

part 'note_state.g.dart';

@freezed
class NoteState with _$NoteState {
  const factory NoteState({
    @Default([]) List<Note> notes,
  }) = _NoteState;

  factory NoteState.fromJson(Map<String, dynamic> json) =>
      _$NoteStateFromJson(json);
}
