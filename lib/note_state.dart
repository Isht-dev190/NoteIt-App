
class NoteState {
  final String id;
  final String title;
  final String content;
  final String category;
  
  const NoteState({
    this.id = '',
    this.title = '',
    this.content = '',
    this.category = 'Work',
  });

  NoteState copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
  }) {
    return NoteState(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
    );
  }
}