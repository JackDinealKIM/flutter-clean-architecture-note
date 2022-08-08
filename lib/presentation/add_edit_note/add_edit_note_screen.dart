import 'dart:async';

import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:clean_architecture_note/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:clean_architecture_note/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  StreamSubscription? _streamSubscription;

  static List<Color> noteColors = [
    roseBud,
    primRose,
    wisteria,
    skyblue,
    illusion
  ];

  Color _color = roseBud;

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }

    Future.microtask(() {
      final viewModel = context.read<AddEditNoteViewModel>();
      _streamSubscription = viewModel.eventStream.listen((event) {
        event.when(saveNote: () {
          Navigator.pop(context, true);
        }, showSnackBar: (String message) {
          final snackBar = SnackBar(content: Text(message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // if (_titleController.text.isEmpty ||
          //     _contentController.text.isEmpty) {
          //   final snackBar = SnackBar(content: Text('제목이나 내용이 비어 있습니다.'));
          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //   return;
          // }

          viewModel.onEvent(AddEditNoteEvent.saveNote(
            widget.note == null ? null : widget.note!.id,
            _titleController.text,
            _contentController.text,
          ));
        },
        child: const Icon(Icons.save),
      ),
      body: AnimatedContainer(
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 48),
        color: _color,
        duration: const Duration(seconds: 1),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: noteColors
                  .map((color) => InkWell(
                        onTap: () {
                          setState(() {
                            _color = color;
                            viewModel.onEvent(AddEditNoteEvent.changeColor(
                              color.value,
                            ));
                          });
                        },
                        child: _buildBackgroundColor(color, _color == color),
                      ))
                  .toList(),
            ),
            TextField(
              controller: _titleController,
              maxLines: 1,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: darkgray,
                  ),
              decoration: const InputDecoration(
                hintText: '제목을 입력하세요.',
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _contentController,
              maxLines: null,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: darkgray,
                  ),
              decoration: const InputDecoration(
                hintText: '내용을 입력하세요.',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundColor(Color color, bool selected) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: selected
            ? Border.all(
                color: Colors.black,
                width: 2,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
    );
  }
}
