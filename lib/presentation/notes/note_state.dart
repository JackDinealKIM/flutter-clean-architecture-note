import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/domain/util/note_order.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_state.freezed.dart';

@freezed
class NoteState with _$NoteState {
  const factory NoteState({
    @Default([]) List<Note> notes,
    required NoteOrder noteOrder,
    required bool isOrderSectionVisible,
  }) = _NoteState;
}
