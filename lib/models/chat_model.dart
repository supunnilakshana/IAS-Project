class ChatModel {
  final String mobileno;
  int newmsgcount;
  late final String? imgurl;
  String? lastmessage;

  ChatModel(
      {required this.mobileno,
      required this.newmsgcount,
      required this.imgurl,
      this.lastmessage = ""});

  Map<String, dynamic> toMap() {
    return {
      'mobileno': mobileno,
      'newmsgcount': newmsgcount,
      'imgurl': imgurl,
      'lastmessage': lastmessage
    };
  }

  ChatModel.fromMap(Map<String, dynamic> res)
      : mobileno = res["mobileno"],
        newmsgcount = res["newmsgcount"],
        imgurl = res["imgurl"],
        lastmessage = res["lastmessage"];
}
