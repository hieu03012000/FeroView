import 'package:fero/screens/change_avatar_page.dart';
import 'package:fero/screens/login_page.dart';
import 'package:fero/screens/measure_template_page.dart';
import 'package:fero/services/google_sign_in.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/screens/update_profile_page.dart';
import 'package:fero/viewmodels/model_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelProfilePage extends StatefulWidget {
  final String modelId;
  const ModelProfilePage({Key key, this.modelId}) : super(key: key);

  @override
  _ModelProfilePageState createState() => _ModelProfilePageState();
}

class _ModelProfilePageState extends State<ModelProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: FutureBuilder<ModelViewModel>(
              future: Provider.of<ModelViewModel>(context, listen: false)
                  .getModel(widget.modelId),
              builder: (ctx, prevData) {
                if (prevData.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else {
                  if (prevData.error == null) {
                    return Consumer<ModelViewModel>(
                        builder: (ctx, data, child) => Center(
                              child: modelBtn(
                                context: ctx,
                                modelDetail: data,
                              ),
                            ));
                  } else {
                    return Text('Error');
                  }
                }
              },
            ),
          )),
    );
  }

  Widget modelBtn({BuildContext context, ModelViewModel modelDetail}) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'Account',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
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
                      image: NetworkImage(modelDetail.avatar ?? ''),
                      fit: BoxFit.cover)),
            )),
            Positioned(
                bottom: 5,
                right: 125,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CameraWidget(modelId: modelDetail.id),
                        ));
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
        Container(
          width: 50,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  modelDetail.name ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  modelDetail.username ?? '',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-2, 5),
                        blurRadius: 10,
                        color: kPrimaryColor.withOpacity(0.3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFFF0F0F0),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<ModelViewModel>.value(
                                  value: modelDetail,
                                  child: UpdateModelProfilePage(
                                      modelId: modelDetail.id))));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.supervised_user_circle_sharp,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            'My account',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-2, 5),
                        blurRadius: 10,
                        color: kPrimaryColor.withOpacity(0.3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFFF0F0F0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MeasureTemplatePage(
                              modelId: widget.modelId, template: '1',
                            ),
                          ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.straighten,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            'Measure',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-2, 5),
                        blurRadius: 10,
                        color: kPrimaryColor.withOpacity(0.3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFFF0F0F0),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.logout();
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => MultiProvider(providers: [
                                    ChangeNotifierProvider(
                                        create: (_) => GoogleSignInProvider()),
                                  ], child: LoginPage())));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            'Logout',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
