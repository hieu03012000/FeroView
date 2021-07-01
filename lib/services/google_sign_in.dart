import 'dart:convert';

import 'package:fero/models/login.dart';
import 'package:fero/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;

  Future<int> googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw Exception('Not choose');
      _user = googleUser;

      final modelLogin = await loginDB(googleUser.email);

      if (modelLogin == null) {
        await googleSignIn.disconnect();
        Fluttertoast.showToast(msg: 'Please create account');
        throw Exception('Please create account');
      }

      await FlutterSession().set("modelId", modelLogin.id);
      await FlutterSession().set("modelName", modelLogin.name);
      await FlutterSession().set("modelStatus", modelLogin.status);

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      Fluttertoast.showToast(msg: 'Login success');

      notifyListeners();

      return modelLogin.status;
    } catch (e) {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }
      throw Exception(e);
    }
  }

  Future<GoogleSignInAccount> googleSignUp() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw Exception('Not choose');
      _user = googleUser;

      final modelLogin = await loginDB(googleUser.email);

      if (modelLogin != null) {
        await googleSignIn.disconnect();
        Fluttertoast.showToast(msg: 'Your account existed');
        throw Exception('Your account existed');
      }
      notifyListeners();
      return _user;
    } catch (e) {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }
      throw Exception(e);
    }
  }

  Future createAccountDB(Map<String, dynamic> params, GoogleSignInAccount user) async {
    final message = jsonEncode(params);
    final response = await http.post(Uri.parse(baseUrl + 'api/v1/models'),
        body: message, headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      var responseBody = LoginModel.fromJson(jsonDecode(response.body));
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      Fluttertoast.showToast(msg: 'Create success');
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }
      return responseBody;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future logout() async {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
    }
    FirebaseAuth.instance.signOut();
  }

  Future<LoginModel> loginDB(String mail) async {
    final response =
        await http.get(Uri.parse(baseUrl + 'api/v1/models/' + mail + '/model'));
    if (response.statusCode == 200) {
      var responseBody = LoginModel.fromJson(jsonDecode(response.body));
      return responseBody;
    } else {
      return null;
    }
  }
}
