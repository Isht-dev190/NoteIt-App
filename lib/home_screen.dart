import 'package:assignment3_noteit/category_cubit.dart';
import 'package:assignment3_noteit/noteCard.dart';
import 'package:assignment3_noteit/note_model.dart';
import 'package:assignment3_noteit/notelist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: BlocBuilder<CategoryCubit, String>(
          builder: (context, selectedCategory) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'NoteIt',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          context.read<CategoryCubit>().changeCategory(newValue);
                        }
                      },
                      items: ['All', 'Personal', 'Work', 'Study']
                          .map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),

      body: BlocBuilder<CategoryCubit, String>(
        builder: (context, selectedCategory) {
          return BlocBuilder<NoteListCubit, List<Note>>(
            builder: (context, notes) {
              final filteredNotes = selectedCategory == 'All'
                  ? notes
                  : notes.where((note) => note.category == selectedCategory).toList();

              if (filteredNotes.isEmpty) {
                return const Center(child: Text("No notes found."));
              }

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  itemCount: filteredNotes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    return Notecard(
                    note: filteredNotes[index],
                    onDelete: (noteId) {
                      context.read<NoteListCubit>().deleteNote(noteId);
                    },
                  );

                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add_note'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
