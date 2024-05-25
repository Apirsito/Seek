class ErrorModel {
  String title;
  String description;
  ErrorModel({
    required this.title,
    required this.description,
  });

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Task( title: $title, description: $description)';
  }
}
