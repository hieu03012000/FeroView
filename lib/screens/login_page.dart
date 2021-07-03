import 'package:fero/animations/fade_animation.dart';
import 'package:fero/screens/create-account-page.dart';
import 'package:fero/screens/main_screen_not_active.dart';
import 'package:fero/screens/main_screen.dart';
import 'package:fero/services/google_sign_in.dart';
import 'package:fero/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController, passwordController;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void _loadData() {
    emailController = TextEditingController()..text = "";
    passwordController = TextEditingController()..text = "";
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [kPrimaryColor, kSecondaryColor])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      'Login',
                      style: TextStyle(
                        color: kBackgroundColor,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeAnimation(
                      1,
                      Text(
                        'Wellcome back',
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 18,
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(-20, -10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: kPrimaryColor,
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                            )),
                        SizedBox(
                          height: 200,
                        ),
                        FadeAnimation(
                            1,
                            ElevatedButton.icon(
                                icon: FaIcon(FontAwesomeIcons.google),
                                onPressed: () {
                                  final provider =
                                      Provider.of<GoogleSignInProvider>(context,
                                          listen: false);
                                  provider
                                      .googleLogin()
                                      .then((value) => {
                                            if (value == 1)
                                              {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen(page: 2),
                                                ))
                                              },
                                            if (value == 0)
                                              {
                                               Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreenNotActive(page: 1),
                                                ))
                                              }
                                          })
                                      .catchError((e) => print(e));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  primary: kPrimaryColor,
                                  elevation: 0,
                                  minimumSize: Size(10, 50),
                                ),
                                label: Text(
                                  'Login with Google',
                                  style: TextStyle(
                                      color: kBackgroundColor, fontSize: 20),
                                ))),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1,
                            GestureDetector(
                              onTap: () {
                                final provider =
                                    Provider.of<GoogleSignInProvider>(context,
                                        listen: false);
                                provider
                                    .googleSignUp()
                                    .then((value) => {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MultiProvider(
                                                          providers: [
                                                            ChangeNotifierProvider(
                                                                create: (_) =>
                                                                    GoogleSignInProvider()),
                                                          ],
                                                          child:
                                                              CreateAccountPage(
                                                            account: value,
                                                          )))),
                                        })
                                    .catchError((e) => print(e));
                              },
                              child: Text(
                                'Create new account',
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 16),
                              ),
                            )),
                      ],
                    )),
              ),
            )
          ],
        ),
      )),
    );
  }
}
