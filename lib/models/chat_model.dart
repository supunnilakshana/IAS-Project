class ChatModel {
  final String mobileno;
  final int newmsgcount;
  final String? imgurl;

  ChatModel({
    required this.mobileno,
    required this.newmsgcount,
    required this.imgurl,
  });

  Map<String, dynamic> toMap() {
    return {'mobileno': mobileno, 'newmsgcount': newmsgcount, 'imgurl': imgurl};
  }

  ChatModel.fromMap(Map<String, dynamic> res)
      : mobileno = res["mobileno"],
        newmsgcount = res["newmsgcount"],
        imgurl = res["imgurl"];
}
