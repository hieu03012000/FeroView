import 'package:fero/screens/login_page.dart';
import 'package:fero/services/google_sign_in.dart';
import 'package:fero/utils/common.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class CreateAccountPage extends StatefulWidget {
  final GoogleSignInAccount account;
  CreateAccountPage({Key key, this.account}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            CreateTextBox(
              account: widget.account,
            )
          ],
        ),
      ),
    );
  }
}

class CreateTextBox extends StatefulWidget {
  final GoogleSignInAccount account;
  CreateTextBox({Key key, this.account}) : super(key: key);

  @override
  _CreateTextBoxState createState() => _CreateTextBoxState();
}

class _CreateTextBoxState extends State<CreateTextBox> {
  DateTime _date;
  int genderController;
  TextEditingController mailController,
      nameController,
      dobController,
      phoneController,
      addressController,
      giftedController;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    phoneController.dispose();
    addressController.dispose();
    giftedController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1190, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              surface: kPrimaryColor,
              onSurface: Colors.black,
              primaryVariant: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        dobController = TextEditingController()
          ..text = formatDate(newDate.toString());
      });
    }
  }

  void _loadData() {
    mailController = TextEditingController()
      ..text = widget.account.email.toString();
    nameController = TextEditingController()
      ..text = widget.account.displayName.toString();
    genderController = 0;
    dobController = TextEditingController()
      ..text = formatDate(DateTime.now().toString());
    phoneController = TextEditingController()..text = '';
    addressController = TextEditingController()..text = '';
    giftedController = TextEditingController()..text = '';
    _date = DateTime.now();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.only(left: 20, right: 20),
        child: Expanded(
      child: SizedBox(
        width: 320,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Stack(
                children: [
                  Center(
                      child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(-2, 5),
                            blurRadius: 10,
                            color: kPrimaryColor.withOpacity(0.3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(80),
                        image: DecorationImage(
                            image: NetworkImage(widget.account.photoUrl ?? ''),
                            fit: BoxFit.cover)),
                  )),
                  Positioned(
                      bottom: 1,
                      right: 115,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           CameraWidget(modelId: modelDetail.id),
                          //     ));
                        },
                        child: ClipOval(
                            child: Container(
                                padding: EdgeInsets.all(3),
                                color: kBackgroundColor,
                                child: ClipOval(
                                    child: Container(
                                  padding: EdgeInsets.all(5),
                                  color: kPrimaryColor,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                )))),
                      )),
                ],
              ),
              TextFormField(
                controller: mailController,
                cursorColor: kPrimaryColor,
                enabled: false,
                decoration: InputDecoration(
                  icon: Icon(Icons.mail_outline),
                  labelText: 'Email',
                  // suffixIcon: Icon(
                  //   Icons.check_circle,
                  // ),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
                controller: nameController,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(Icons.drive_file_rename_outline),
                  labelText: 'Name',
                ),
              ),
              DropdownButtonFormField(
                value: genderController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Gender',
                ),
                items: [
                  DropdownMenuItem(
                    child: Text("Male"),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text("Female"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("Other"),
                    value: 3,
                  )
                ],
                onChanged: (int value) {
                  setState(() {
                    genderController = value;
                  });
                },
              ),
              Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: dobController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: InputDecoration(
                        icon: Icon(Icons.cake),
                        labelText: 'Date of birth',
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Center(
                        child: ElevatedButton.icon(
                          onPressed: _selectDate,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            elevation: 0,
                            minimumSize: Size(10, 50),
                            onPrimary: kPrimaryColor,
                          ),
                          icon: Icon(
                            Icons.calendar_today,
                          ),
                          label: Text(''),
                        ),
                      )),
                ],
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.length < 10 || value.length > 12) {
                    return 'Please enter valid phone number';
                  }
                  return null;
                },
                cursorColor: kPrimaryColor,
                controller: phoneController,
                maxLength: 12,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.call),
                  labelText: 'Phone number',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                  cursorColor: kPrimaryColor,
                  controller: addressController,
                  maxLength: 100,
                  maxLines: 2,
                  decoration: InputDecoration(
                    icon: Icon(Icons.home),
                    labelText: 'Address',
                  )),
              TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: giftedController,
                  maxLength: 100,
                  maxLines: 2,
                  decoration: InputDecoration(
                    icon: Icon(Icons.star_outline),
                    labelText: 'Gifted',
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('CREATE'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Map<String, dynamic> params = Map<String, dynamic>();
                    params['name'] = nameController.text;
                    params['gender'] = genderController;
                    params['dateOfBirth'] = _date.toString();
                    params['subAddress'] = addressController.text;
                    params['phone'] = phoneController.text;
                    params['gifted'] = giftedController.text;
                    params['username'] = mailController.text;
                    params['avatar'] = widget.account.photoUrl;
                    await Provider.of<GoogleSignInProvider>(context,
                            listen: false)
                        .createAccountDB(params, widget.account);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MultiProvider(providers: [
                              ChangeNotifierProvider(
                                  create: (_) => GoogleSignInProvider()),
                            ], child: LoginPage())));
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  elevation: 0,
                  minimumSize: Size(10, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
