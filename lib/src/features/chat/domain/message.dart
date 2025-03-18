import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  const Message({
    required this.content,
    required this.roomID,
    required this.senderID,
    required this.timestamp,
  });

  final String content;
  final String roomID;
  final String senderID;
  final DateTime timestamp;

  factory Message.fromFirestore(Map<String, dynamic> data) {
    return Message(
      content: data['content'] ?? '',
      senderID: data['senderID'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      roomID: data['roomID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'roomID': roomID,
      'senderID': senderID,
      'timestamp': timestamp,
    };
  }
}
