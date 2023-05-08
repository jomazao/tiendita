import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendita/models/app_user.dart';

class UsersRepository {
  final _firestore = FirebaseFirestore.instance;
  Stream<List<AppUser>> usersStream() {
    return _firestore.collection('users').snapshots().map((event) => event.docs
        .map((doc) => AppUser.fromJson(id: doc.id, json: doc.data()))
        .toList());
  }

  final users = [
    {"name": "Naty"},
    {"name": "Gabriel"},
    {"name": "Cristian S"},
    {"name": "Nicolás"},
    {"name": "Daniela"},
    {"name": "Juan"},
    {"name": "Luisa"},
    {"name": "Santiago A"},
    {"name": "Diego"},
    {"name": "Juanita"},
    {"name": "Johana Castañeda"},
    {"name": "Cristian Robelto"},
    {"name": "Andrea"},
    {"name": "Mariana"},
    {"name": "Angie"},
    {"name": "Ines"},
    {"name": "Hugo"},
    {"name": "Duván"},
    {"name": "Manuel"},
    {"name": "Natalia"},
    {"name": "Ivonne"},
    {"name": "Alejandra"},
    {"name": "Valentina"},
    {"name": "Nicol"},
    {"name": "Sleyner"},
    {"name": "Sebastian"},
    {"name": "Nilson Andrés"},
    {"name": "Mathew"},
    {"name": "Cristian A"},
    {"name": "Gersón"},
    {"name": "Mariapai"},
    {"name": "Santiago B"},
    {"name": "Nicolas Gil"},
    {"name": "Jonathan"}
  ];

  Future<void> inserUsers() async {
    var cont = 0;
    for (final user in users) {
      await _firestore.collection('users').add(user);
    }
  }
}
