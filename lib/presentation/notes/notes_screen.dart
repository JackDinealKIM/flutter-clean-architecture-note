import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:clean_architecture_note/presentation/notes/components/note_item.dart';
import 'package:clean_architecture_note/presentation/notes/components/order_section.dart';
import 'package:clean_architecture_note/presentation/notes/notes_event.dart';
import 'package:clean_architecture_note/presentation/notes/notes_view_model.dart';
import 'package:clean_architecture_note/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(onPressed: () {
            viewModel.onEvent(const NotesEvent.toggleOrderSection());
          }, icon: const Icon(Icons.sort)),
        ],
        centerTitle: true,
        title: const Text(
          'Your Note',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            AnimatedSwitcher(
              duration: const Duration(microseconds: 300),
              child: state.isOrderSectionVisible
                  ? OrderSection(
                      noteOrder: state.noteOrder,
                      onOrderChanged: (noteOrder) {
                        viewModel.onEvent(NotesEvent.changeOrder(noteOrder));
                      },
                    )
                  : Container(),
            ),
            ...state.notes
                .map((note) => GestureDetector(
                      onTap: () async {
                        bool? isSaved = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditNoteScreen(
                                note: note,
                              ),
                            ));

                        if (isSaved != null && isSaved) {
                          viewModel.onEvent(const NotesEvent.loadNotes());
                        }
                      },
                      child: NoteItem(
                        note: note,
                        onDeleteTap: () {
                          viewModel.onEvent(NotesEvent.deleteNotes(note));

                          final snackBar = SnackBar(
                            content: Text('노트가 삭제되었습니다.'),
                            action: SnackBarAction(
                              label: '취소',
                              onPressed: () {
                                viewModel
                                    .onEvent(const NotesEvent.restoreNote());
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ))
                .toList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? isSaved = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEditNoteScreen()));
          if (isSaved != null && isSaved) {
            viewModel.onEvent(const NotesEvent.loadNotes());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
