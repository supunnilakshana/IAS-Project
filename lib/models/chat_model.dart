class ChatModel {
  final String mobileno;
  final int newmsgcount;

  ChatModel({
    required this.mobileno,
    required this.newmsgcount,
  });

  Map<String, dynamic> toMap() {
    return {'mobileno': mobileno, 'newmsgcount': newmsgcount};
  }

  ChatModel.fromMap(Map<String, dynamic> res)
      : mobileno = res["mobileno"],
        newmsgcount = res["newmsgcount"];
}
