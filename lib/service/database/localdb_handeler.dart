import 'package:path/path.dart';
import 'package:smsapp/models/chat_model.dart';
import 'package:smsapp/models/msg_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbHandeler {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'smslocal.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE msg(id INTEGER PRIMARY KEY AUTOINCREMENT, mobileno TEXT NOT NULL, message TEXT NOT NULL, msgtype INTEGER NOT NULL, status TEXT NOT NULL, hash TEXT, datetime TEXT NOT NULL)",
        );
        await database.execute(
          "CREATE TABLE chat(mobileno TEXT PRIMARY KEY,newmsgcount newmsg INTEGER NOT NULL, imgurl TEXT, lastmessage TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<int> createnewchat(ChatModel model) async {
    int result = 0;
    final Database db = await initializeDB();

    try {
      result = await db.insert('chat', model.toMap());
      result = 1;
    } on Exception catch (e) {
      print(e);
    }

    return result;
  }

  static Future<int> addnewmsg(MsgModel model) async {
    int result = 0;
    final Database db = await initializeDB();

    try {
      result = await db.insert('msg', model.toMap());
      result = 1;
    } on Exception catch (e) {
      print(e);
    }

    return result;
  }

  static Future<List<ChatModel>> getallchat() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('chat');
    return queryResult.map((e) => ChatModel.fromMap(e)).toList();
  }

  static Future<List<MsgModel>> getallmsgs(String mobile) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'msg',
      where: "mobileno = ?",
      whereArgs: [mobile],
    );
    return queryResult.map((e) => MsgModel.fromMap(e)).toList();
  }

  static Future<int> checkchatstaus(String mobile) async {
    int res = 0;
    try {
      final Database db = await initializeDB();
      final List<Map<String, Object?>> queryResult = await db.query(
        'chat',
        where: "mobileno = ?",
        whereArgs: [mobile],
      );

      res = queryResult.length;
    } on Exception catch (e) {
      print(e);
    }
    return res;
  }

  static Future<ChatModel?> getsingelchat(String mobile) async {
    try {
      ChatModel chatModel;
      final Database db = await initializeDB();
      final List<Map<String, Object?>> queryResult = await db.query(
        'chat',
        where: "mobileno = ?",
        whereArgs: [mobile],
      );
      if (queryResult.length != 0) {
        chatModel = ChatModel.fromMap(queryResult.first);
        return chatModel;
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<int> clearachat(String mobile) async {
    int res = 0;
    try {
      final db = await initializeDB();
      await db.delete(
        'chat',
        where: "mobileno = ?",
        whereArgs: [mobile],
      );
      res = 1;
    } on Exception catch (e) {
      print(e);
    }
    return res;
  }

  static Future<int> clearallmsg(String mobile) async {
    int res = 0;
    try {
      final db = await initializeDB();
      await db.delete(
        'msg',
        where: "mobileno = ?",
        whereArgs: [mobile],
      );
      res = 1;
    } on Exception catch (e) {
      print(e);
    }
    return res;
  }

  static Future<int> updatechat(ChatModel model) async {
    int res = 0;
    try {
      final db = await initializeDB();
      await db.update(
        'chat',
        model.toMap(),
        where: "mobileno = ?",
        whereArgs: [model.mobileno],
      );
      res = 1;
    } on Exception catch (e) {
      print(e);
    }
    return res;
  }
}
