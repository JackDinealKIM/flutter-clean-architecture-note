import 'dart:collection';

import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/domain/repository/note_repository.dart';
import 'package:clean_architecture_note/presentation/notes/note_state.dart';
import 'package:clean_architecture_note/presentation/notes/notes_event.dart';
import 'package:flutter/material.dart';

class NotesViewModel with ChangeNotifier {
  final NoteRepository repository;

  NotesViewModel(this.repository);

  NoteState _state = NoteState();

  NoteState get state => _state;
  Note? _recentlyDeletedNote;

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNotes: (note) => _deleteNotes(note),
      restoreNote: _restoreNotes,
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await repository.getNotes();
    _state = state.copyWith(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNotes(Note note) async {
    _recentlyDeletedNote = note;
    await repository.deleteNote(note.id!);
    await _loadNotes();
  }

  Future<void> _restoreNotes() async {
    if (_recentlyDeletedNote != null) {
      await repository.insertNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;
      _loadNotes();
    }
  }
}
