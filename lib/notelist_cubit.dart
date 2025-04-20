// note_list_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment3_noteit/note_model.dart';

class NoteListCubit extends Cubit<List<Note>> {
  NoteListCubit() : super([]);

  
void addOrUpdateNote(Note note) {
  final index = state.indexWhere((n) => n.id == note.id);

  if (index != -1) {
    // Update existing note
    final updated = List<Note>.from(state);
    updated[index] = note;
    emit(updated);
  } else {
    // Add new note
    emit([...state, note]);
  }
}


  void deleteNote(String id) {
  state.removeWhere((note) => note.id == id);
  emit(List.from(state)); 
}

}
