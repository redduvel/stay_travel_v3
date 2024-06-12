class Message {
  final String clienId;
  final String businessmanId;
  final String status;
  final String message;

  Message({required this.clienId, required this.businessmanId, required this.status, required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      clienId: json['client_id'], 
      businessmanId: json['businessman_id'], 
      status: json['status'], 
      message: json['message']);
  }

    Map<String, dynamic> toJson() {
    return {
      'client_id': clienId,
      'businessman_id': businessmanId,
      'status': status,
      'message': message
    };
  }

}