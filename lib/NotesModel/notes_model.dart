class NoteModel {
  String? date;
  String? userId;
  String? description;

  NoteModel({
    required this.date,
    required this.description,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {"date": date, "userId": userId, "description": description};
  }
}
