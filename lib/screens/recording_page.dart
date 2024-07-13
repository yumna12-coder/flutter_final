import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/model/video_model.dart';

class RecordingVideosPage extends StatefulWidget {
  @override
  _RecordingVideosPageState createState() => _RecordingVideosPageState();
}

class _RecordingVideosPageState extends State<RecordingVideosPage> {
  final List<RecordingVideo> _recordingVideos = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final CollectionReference videosCollection = FirebaseFirestore.instance.collection('videos');

  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  @override
  void initState() {
    super.initState();
    _loadRecordingVideos();
  }

  Future<void> _loadRecordingVideos() async {
    String userId = getCurrentUserId();
    QuerySnapshot querySnapshot = await videosCollection.where('userId', isEqualTo: userId).get();
    List<RecordingVideo> loadedVideos = querySnapshot.docs
        .map((doc) => RecordingVideo.fromFirestore(doc))
        .toList();
    
    setState(() {
      _recordingVideos.addAll(loadedVideos);
    });
  }

  Future<void> _addRecordingVideo() async {
    String userId = getCurrentUserId();
    if (_titleController.text.isNotEmpty && _urlController.text.isNotEmpty) {
      RecordingVideo newVideo = RecordingVideo(
        title: _titleController.text,
        url: _urlController.text,
        userId: userId,
        createdAt: Timestamp.now(), // Capture current timestamp
      );

      await videosCollection.add(newVideo.toMap());
      setState(() {
        _recordingVideos.add(newVideo);
      });

      _titleController.clear();
      _urlController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recording Videos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Video Title'),
            ),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'Video URL'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addRecordingVideo,
              child: Text('Add Recording Video'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _recordingVideos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_recordingVideos[index].title),
                    subtitle: Text(_recordingVideos[index].url),
                    onTap: () {
                      // Handle video playback
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}