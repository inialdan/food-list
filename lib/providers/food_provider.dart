import 'package:food_app/models/food.dart';
import 'package:food_app/services/auth.dart';
import 'package:food_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodProvider with ChangeNotifier {
  final firestore = Firestore();
  final auth = Auth();

  late String _title = "";
  late String _image =
      "https://firebasestorage.googleapis.com/v0/b/food-app-ff7e9.appspot.com/o/buku%20pelajaran.jpg?alt=media&token=a637b4ca-d9b0-4a21-968f-1412f968cba1";
  late String _detail = "";
  late String _email = "";
  late String _password = "";
  late bool _isDark = false;

  // Getter
  bool get isDark => _isDark;
  Brightness get brigthness => (_isDark) ? Brightness.dark : Brightness.light;
  String get title => _title;
  String get image => _image;
  String get detail => _detail;
  String get email => _email;
  String get password => _password;
  Color get color => (_isDark) ? Colors.white : Colors.black;
  Stream<List<Food>> get getFoods => firestore.getFoodList();

  // Setter
  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  set image(String value) {
    _image = value;
    notifyListeners();
  }

  set detail(String value) {
    _detail = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  // Function

  login(BuildContext context) async {
    if (_email == "" || _password == "") {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ada Data Yang Kosong"),
        ),
      );
    } else {
      var result = await auth.login(_email, _password);
      if (result == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Berhasil Login"),
          ),
        );
        return Navigator.popAndPushNamed(context, '/home');
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result),
          ),
        );
      }
    }
  }

  register(BuildContext context) async {
    if (_email == "" || _password == "") {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ada Data Yang Kosong"),
        ),
      );
    } else {
      var result = await auth.register(_email, _password);
      if (result == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Berhasil Register"),
          ),
        );
        return Navigator.popAndPushNamed(context, '/home');
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result),
          ),
        );
      }
    }
  }

  logout(BuildContext context) {
    auth.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Logout Berhasil"),
      ),
    );
    return Navigator.popAndPushNamed(context, '/');
  }

  addFood(BuildContext context) async {
    if (_title == "" || _detail == "") {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ada Data Yang Kosong"),
        ),
      );
    } else {
      var books = Food(title: _title, detail: _detail, image: _image);
      _title = "";
      _detail = "";
      _image = "";

      var result = await firestore.addFood(books);
      if (result == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Berhasil Menambahkan Note"),
          ),
        );
        return Navigator.popAndPushNamed(context, '/home');
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result),
          ),
        );
      }
    }
  }

  updateFood(
    String id,
    BuildContext context,
    DocumentSnapshot snapshot,
  ) async {
    var books = Food(
      title: _title == "" ? snapshot['title'] : _title,
      detail: _detail == "" ? snapshot['detail'] : _detail,
      image: _image == "" ? snapshot['image'] : _image,
    );
    var result = await firestore.updateFood(id, books);
    if (result == 'ok') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data berhasil diubah!"),
        ),
      );
      return Navigator.popAndPushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
        ),
      );
    }
  }

  deleteFood(String id, BuildContext context) async {
    firestore.removeFood(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data Sudah Dihapus")),
    );
  }
}
