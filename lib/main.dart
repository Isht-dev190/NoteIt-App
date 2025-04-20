import 'package:assignment3_noteit/category_cubit.dart';
import 'package:assignment3_noteit/noteCubit.dart';
import 'package:assignment3_noteit/notelist_cubit.dart';
import 'package:assignment3_noteit/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
 runApp(
     MultiBlocProvider(
      providers: [
      BlocProvider(create: (context) => CategoryCubit()), 
        BlocProvider(create: (context) => NoteCubit()),
        BlocProvider(create: (_) => NoteListCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, 
      routerConfig: router,
    );
  }
}
