// add_note.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:assignment3_noteit/noteCubit.dart';
import 'package:assignment3_noteit/note_state.dart';
import 'package:assignment3_noteit/notelist_cubit.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    final noteCubit = context.read<NoteCubit>();
    final listCubit = context.read<NoteListCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  onChanged: noteCubit.updateTitle,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: noteCubit.updateContent,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: state.category.isEmpty ? 'Work' : state.category,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Work', 'Study', 'Personal']
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      noteCubit.updateCategory(value);
                    }
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[200],
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    onPressed: () {
                      if (state.title.trim().isEmpty || state.content.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Title and Content cannot be empty"),
                            backgroundColor: const Color.fromARGB(156, 255, 82, 82),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        noteCubit.addNote(listCubit);
                        context.pop(); // go back to HomeScreen
                      }
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
