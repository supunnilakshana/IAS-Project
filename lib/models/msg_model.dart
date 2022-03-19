class MsgModel {
  final int? id;
  final String mobileno;
  final String message;
  final int msgtype;
  final String status;
  final String datetime;
  String hash;

  MsgModel({
    this.id,
    required this.mobileno,
    required this.message,
    required this.status,
    required this.hash,
    required this.msgtype,
    required this.datetime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mobileno': mobileno,
      'message': message,
      'status': status,
      'hash': hash,
      'msgtype': msgtype,
      'datetime': datetime
    };
  }

  MsgModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        mobileno = res["mobileno"],
        message = res["message"],
        status = res["status"],
        hash = res["hash"],
        msgtype = res["msgtype"],
        datetime = res["datetime"];
}
