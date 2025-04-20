import 'package:assignment3_noteit/noteCubit.dart';
import 'package:assignment3_noteit/note_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Notecard extends StatelessWidget {
  final Note note;
  final void Function(String) onDelete;
  Notecard({required this.note, required this.onDelete, super.key});
 late NoteCubit noteCubit = NoteCubit();
@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
  builder: (_) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title - multiline, fully shown
              Expanded(
                child: Text(
                  note.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 8),
              /// Category Chip
              Chip(
                label: Text(note.category),
                backgroundColor: noteCubit.getColorForCategory(note.category),
              ),
            ],
          ),
          SizedBox(height: 12),
          
          /// Full note content
          Text(
            note.content,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}


      );
    },
    child: Transform.rotate(
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
            Text(note.title, maxLines: 1,overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
    ),
  );
}

}
