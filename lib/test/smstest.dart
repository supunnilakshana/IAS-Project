// import 'package:flutter/material.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_string_encryption/flutter_string_encryption.dart';

// class Test1 extends StatefulWidget {
//   @override
//   _Test1State createState() => _Test1State();
// }

// class _Test1State extends State<Test1> {
//   TextEditingController controller = TextEditingController();
//   String encryptedtext = 'Encrypted Text';
//   String decryptedtext = 'Decrypted Text';
//   late PlatformStringCryptor cryptor;
//   String final_key = '';

//   void encrypt() async {
//     cryptor = PlatformStringCryptor();
//     final salt = await cryptor.generateSalt();
//     String key = await cryptor.generateKeyFromPassword(controller.text, salt);
//     String encrypted = await cryptor.encrypt(controller.text, key);

//     setState(() {
//       final_key = key;
//       encryptedtext = encrypted;
//     });
//   }

//   void decrypt() async {
//     try {
//       String decrypted = await cryptor.decrypt(encryptedtext, final_key);
//       setState(() {
//         decryptedtext = decrypted;
//       });
//     } on MacMismatchException {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Encryption')),
//         body: SingleChildScrollView(
//           child: Container(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextField(
//                     controller: controller,
//                   ),
//                   SizedBox(height: 20),
//                   TextButton(
//                       onPressed: () {
//                         encrypt();
//                       },
//                       child: Container(
//                           color: Colors.blue,
//                           width: 300,
//                           height: 50,
//                           child: Center(
//                               child: Text(
//                             'Encrypt',
//                             style: TextStyle(color: Colors.white),
//                           )))),
//                   SizedBox(height: 20),
//                   Text(
//                     encryptedtext,
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 20),
//                   TextButton(
//                       onPressed: () {
//                         decrypt();
//                       },
//                       child: Container(
//                           color: Colors.blue,
//                           width: 300,
//                           height: 50,
//                           child: Center(
//                               child: Text(
//                             'Decrypt',
//                             style: TextStyle(color: Colors.white),
//                           )))),
//                   SizedBox(height: 20),
//                   Text(
//                     decryptedtext,
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ],
//               )),
//         ));
//   }
// }
