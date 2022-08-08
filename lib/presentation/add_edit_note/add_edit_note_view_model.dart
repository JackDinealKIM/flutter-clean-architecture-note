import 'dart:async';

import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/domain/repository/note_repository.dart';
import 'package:clean_architecture_note/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:clean_architecture_note/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:clean_architecture_note/ui/colors.dart';
import 'package:flutter/material.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final NoteRepository repository;

  AddEditNoteViewModel(this.repository);

  final _eventController = StreamController<AddEditNoteUiEvent>.broadcast();
  Stream<AddEditNoteUiEvent> get eventStream => _eventController.stream;

  int _color = roseBud.value;

  int get color => _color;

  void onEvent(AddEditNoteEvent event) {
    event.when(changeColor: _changeColor, saveNote: _saveNote);
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    if(title.isEmpty || content.isEmpty) {
      _eventController.add(const AddEditNoteUiEvent.showSnackBar("제목이나 내용이 비어 있습니다."));

      return;
    }
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

    _eventController.add(const AddEditNoteUiEvent.saveNote());
  }
}
