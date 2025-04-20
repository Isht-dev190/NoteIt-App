import 'package:assignment3_noteit/add_note.dart';
import 'package:assignment3_noteit/edit_note.dart';
import 'package:assignment3_noteit/home_screen.dart';
import 'package:assignment3_noteit/noteCubit.dart';
import 'package:assignment3_noteit/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
      GoRoute(path: '/', builder: (context, state) => HomeScreen()),
        GoRoute(
          path: '/add_note',
          builder: (context, state) {
            return BlocProvider(
              create: (_) => NoteCubit(), // <- fresh cubit each time
              child: AddNote(),
            );
          },
        ),
      GoRoute(path: '/edit_note', builder: (context, state) { 
        final note = state.extra as Note;
       return EditNote(note: note);
       } ),

  ]

);