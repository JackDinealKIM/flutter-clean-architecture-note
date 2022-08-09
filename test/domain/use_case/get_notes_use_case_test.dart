import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/domain/repository/note_repository.dart';
import 'package:clean_architecture_note/domain/use_case/get_notes_use_case.dart';
import 'package:clean_architecture_note/domain/util/note_order.dart';
import 'package:clean_architecture_note/domain/util/order_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_notes_use_case_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  test('정렬 기능이 잘 동작해야 한다.', () async {
    final repository = MockNoteRepository();
    final getNotes = GetNotesUseCase(repository);

    // Stub a mock method before interacting.
    when(repository.getNotes()).thenAnswer((_) async => [
      Note(title: 'title', content: 'content', color: 1, timestamp: 1),
      Note(title: 'title2', content: 'content2', color: 2, timestamp: 3),
    ]);

    List<Note> result = await getNotes(NoteOrder.date(const OrderType.descending()));
    expect(result, isA<List<Note>>());
    expect(result.first.timestamp, 3);
    verify(repository.getNotes());

    result = await getNotes(NoteOrder.date(const OrderType.ascending()));
    expect(result.first.timestamp, 1);
    verify(repository.getNotes());

    result = await getNotes(NoteOrder.title(const OrderType.ascending()));
    expect(result.first.title, 'title');
    verify(repository.getNotes());

    verifyNoMoreInteractions(repository);
  });
}