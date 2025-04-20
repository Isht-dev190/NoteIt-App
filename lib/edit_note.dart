import 'package:assignment3_noteit/noteCubit.dart';
import 'package:assignment3_noteit/note_model.dart';
import 'package:assignment3_noteit/note_state.dart';
import 'package:assignment3_noteit/notelist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditNote extends StatelessWidget {
  final Note note; 

  EditNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit()..initializeNote(note), 
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Edit Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<NoteCubit, NoteState>(
            builder: (context, state) {
              final cubit = context.read<NoteCubit>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title Field
                  TextField(
                    controller: context.read<NoteCubit>().titleController,                    
                    onChanged: cubit.updateTitle,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Content Field
                  TextField(
                  controller: context.read<NoteCubit>().contentController,                   
                   onChanged: cubit.updateContent,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Category Dropdown
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
                        cubit.updateCategory(value); 
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Update Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[200],
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      onPressed: () {
                        final listCubit = context.read<NoteListCubit>();
                        cubit.saveNote(listCubit); 
                        context.pop(); 
                      },
                      child: const Text("UPDATE"),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
