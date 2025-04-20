import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment3_noteit/note_model.dart';
import 'package:assignment3_noteit/note_state.dart';
import 'package:assignment3_noteit/notelist_cubit.dart';
import 'package:uuid/uuid.dart';

class NoteCubit extends Cubit<NoteState> {
  Note? _originalNote; // Used only for edit
  late final TextEditingController titleController;
  late final TextEditingController contentController;

  NoteCubit() : super(const NoteState());

  /// Initializes for creating a new note
  void initializeNewNote() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    emit(const NoteState(category: 'Work')); // Default category
    _initializeListeners();
  }

  /// Initializes for editing an existing note
  void initializeNote(Note note) {
    _originalNote = note;
    titleController = TextEditingController(text: note.title);
    contentController = TextEditingController(text: note.content);
    emit(state.copyWith(
      id: note.id,
      title: note.title,
      content: note.content,
      category: note.category,
    ));
    _initializeListeners();
  }

  /// Sets up listeners on text controllers
  void _initializeListeners() {
    titleController.addListener(() => updateTitle(titleController.text));
    contentController.addListener(() => updateContent(contentController.text));
  }

  void updateTitle(String title) => emit(state.copyWith(title: title));
  void updateContent(String content) => emit(state.copyWith(content: content));
  void updateCategory(String category) => emit(state.copyWith(category: category));

  /// Called from AddNote screen
  void addNote(NoteListCubit listCubit) {
    final note = Note(
      id: const Uuid().v4(),
      title: state.title,
      content: state.content,
      category: state.category,
      color: getColorForCategory(state.category),
    );
    listCubit.addOrUpdateNote(note);
  }

  /// Called from EditNote screen
  void updateNote(NoteListCubit listCubit) {
    if (_originalNote == null || state.id == null) return;

    final updatedNote = Note(
      id: state.id!,
      title: titleController.text,
      content: contentController.text,
      category: state.category,
      color: _originalNote!.color,
    );
    listCubit.addOrUpdateNote(updatedNote);
  }

  /// Returns color based on category
  Color getColorForCategory(String category) {
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
