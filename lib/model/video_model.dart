import 'package:cloud_firestore/cloud_firestore.dart';

class RecordingVideo {
  String title;
  String url;
  String userId;
  Timestamp createdAt;

  RecordingVideo({
    required this.title,
    required this.url,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'userId': userId,
      'createdAt': createdAt,
    };
  }

  factory RecordingVideo.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return RecordingVideo(
      title: data['title'],
      url: data['url'],
      userId: data['userId'],
      createdAt: data['createdAt'],
    );
  }
}
