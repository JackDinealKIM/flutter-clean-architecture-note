import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/domain/use_case/use_cases.dart';
import 'package:clean_architecture_note/domain/util/note_order.dart';
import 'package:clean_architecture_note/domain/util/order_type.dart';
import 'package:clean_architecture_note/presentation/notes/note_state.dart';
import 'package:clean_architecture_note/presentation/notes/notes_event.dart';
import 'package:flutter/material.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases userCases;

  NotesViewModel(this.userCases) {
    _loadNotes();
  }

  NoteState _state = NoteState(
    notes: [],
    noteOrder: NoteOrder.date(OrderType.descending()),
    isOrderSectionVisible: false,
  );

  NoteState get state => _state;
  Note? _recentlyDeletedNote;

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNotes: (note) => _deleteNotes(note),
      restoreNote: _restoreNotes,
      changeOrder: (NoteOrder noteOrder) {
        _state = state.copyWith(noteOrder: noteOrder);
        _loadNotes();
      },
      toggleOrderSection: () {
        _state = state.copyWith(
          isOrderSectionVisible: !state.isOrderSectionVisible,
        );
        notifyListeners();
      },
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await userCases.getNotes(state.noteOrder);
    _state = state.copyWith(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNotes(Note note) async {
    _recentlyDeletedNote = note;
    await userCases.deleteNote(note.id!);
    await _loadNotes();
  }

  Future<void> _restoreNotes() async {
    if (_recentlyDeletedNote != null) {
      await userCases.addNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;
      _loadNotes();
    }
  }
}
