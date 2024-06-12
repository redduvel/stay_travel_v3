class Message {
  final String clienId;
  final String businessmanId;
  final String status;
  final String message;

  Message({required this.clienId, required this.businessmanId, required this.status, required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(clienId: json['clientId'], businessmanId: json['businessmanId'], status: json['status'], message: json['message']);
  }

    Map<String, dynamic> toJson() {
    return {
      'clientId': clienId,
      'businessmanId': businessmanId,
      'status': status,
      'message': message
    };
  }

}