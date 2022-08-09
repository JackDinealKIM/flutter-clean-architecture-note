import 'package:clean_architecture_note/data/data_source/note_db_helper.dart';
import 'package:clean_architecture_note/data/repository/note_repository_impl.dart';
import 'package:clean_architecture_note/domain/repository/note_repository.dart';
import 'package:clean_architecture_note/domain/use_case/add_note_use_case.dart';
import 'package:clean_architecture_note/domain/use_case/delete_note_use_case.dart';
import 'package:clean_architecture_note/domain/use_case/get_note_use_case.dart';
import 'package:clean_architecture_note/domain/use_case/get_notes_use_case.dart';
import 'package:clean_architecture_note/domain/use_case/update_note_use_case.dart';
import 'package:clean_architecture_note/domain/use_case/use_cases.dart';
import 'package:clean_architecture_note/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:clean_architecture_note/presentation/notes/notes_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildWidget>> getProviders() async {
  Database db = await openDatabase('notes_db', version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('''
            CREATE TABLE note (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,
                content TEXT,
                color INTEGER,
                timestamp INTEGER
            )
            ''');
      });

  NoteDBHelper dbHelper = NoteDBHelper(db);
  NoteRepository repository = NoteRepositoryImpl(dbHelper);
  UseCases userCases = UseCases(
    AddNoteUseCase(repository),
    DeleteNoteUseCase(repository),
    GetNoteUseCase(repository),
    GetNotesUseCase(repository),
    UpdateNoteUseCase(repository),
  );
  NotesViewModel notesViewModel = NotesViewModel(userCases);
  AddEditNoteViewModel addEditNoteViewModel = AddEditNoteViewModel(repository);

  return [
    ChangeNotifierProvider(create: (_) => notesViewModel),
    ChangeNotifierProvider(create: (_) => addEditNoteViewModel),
  ];
}
