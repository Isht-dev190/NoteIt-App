import 'package:assignment3_noteit/note_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Notecard extends StatelessWidget {
  final Note note;
  final void Function(String) onDelete;

  const Notecard({required this.note, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.03,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(note.content, maxLines: 5, overflow: TextOverflow.ellipsis),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(note.category, style: TextStyle(fontStyle: FontStyle.italic)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () => context.push('/edit_note', extra: note),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.delete, size: 18, color: Colors.redAccent),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Delete Note'),
                          content: Text('Are you sure you want to delete this note?'),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(context),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop(context);
                                onDelete(note.id); 
                              },
                              child: Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },

                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
