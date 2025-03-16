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

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'] as String,
      roomID: json['roomID'] as String,
      senderID: json['senderID'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'roomID': roomID,
      'senderID': senderID,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
