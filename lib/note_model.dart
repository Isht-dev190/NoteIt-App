  import 'dart:ui';

  class Note {
    final String id;
    final String title;
    final String content;
    final String category; 
    final Color color;

    Note({
      required this.id,
      required this.title,
      required this.content,
      required this.category,
      required this.color,
    });
  }