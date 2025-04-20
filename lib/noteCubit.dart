import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment3_noteit/note_model.dart';
import 'package:assignment3_noteit/note_state.dart';
import 'package:assignment3_noteit/notelist_cubit.dart';

class NoteCubit extends Cubit<NoteState> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  NoteCubit() : super(const NoteState());

  void initializeNote(Note note) {
    titleController = TextEditingController(text: note.title);
    contentController = TextEditingController(text: note.content);
    emit(state.copyWith(
      id: note.id,
      title: note.title,
      content: note.content,
      category: note.category,
    ));

    titleController.addListener(() {
      updateTitle(titleController.text);
    });

    contentController.addListener(() {
      updateContent(contentController.text);
    });
  }


  void updateTitle(String title) => emit(state.copyWith(title: title));
  void updateContent(String content) => emit(state.copyWith(content: content));
  void updateCategory(String category) => emit(state.copyWith(category: category));

  
  void saveNote(NoteListCubit listCubit) {
    final updatedNote = Note(
      id: state.id,  
      title: state.title,
      content: state.content,
      category: state.category,
      color: _getColorForCategory(state.category),
    );

    listCubit.addOrUpdateNote(updatedNote); 
  }


  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Work':
        return Colors.amberAccent;
      case 'Study':
        return Colors.lightBlueAccent;
      case 'Personal':
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    contentController.dispose();
    return super.close();
  }
}
