import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/domain/repository/note_repository.dart';
import 'package:clean_architecture_note/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter/material.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final NoteRepository repository;

  AddEditNoteViewModel(this.repository);

  int _color = Colors.orange.value;

  int get color => _color;

  void onEvent(AddEditNoteEvent event) {
    event.when(changeColor: _changeColor, saveNote: _saveNote);
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    if (id == null) {
      await repository.insertNote(Note(
          title: title,
          content: content,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          color: _color));
    } else {
      await repository.updateNote(Note(
          id: id,
          title: title,
          content: content,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          color: _color));
    }
    notifyListeners();
  }
}
