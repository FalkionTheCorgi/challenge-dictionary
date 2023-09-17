class Message {

  bool success;
  String message;

  Message({required this.success, required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return Message(success: json['success'] as bool, message: json['message'] as String);
    } else {
      return Message(success: false, message: 'Unknown Error');
    }
  }
}
