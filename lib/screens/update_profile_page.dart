import 'package:fero/screens/main_screen.dart';
import 'package:fero/utils/common.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/model_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateModelProfilePage extends StatefulWidget {
  final String modelId;
  const UpdateModelProfilePage({Key key, this.modelId}) : super(key: key);

  @override
  _UpdateModelProfilePageState createState() => _UpdateModelProfilePageState();
}

class _UpdateModelProfilePageState extends State<UpdateModelProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: kPrimaryColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Update profile',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(CupertinoIcons.moon_stars, color: Color(0xFFF54E5E),),
        //       onPressed: () => {}
        //   )
        // ],
      ),
      body: Center(
        child: FutureBuilder<ModelViewModel>(
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
                // return Consumer<ModelViewModel>(
                //     builder: (ctx, data, child) => ModelUpdate(
                //           modelDetail: data,
                //         ));
                return ModelUpdate(
                    modelDetail:
                        Provider.of<ModelViewModel>(context, listen: false));
              } else {
                return Text('Error');
              }
            }
          },
        ),
      ),
    );
  }
}

class ModelUpdate extends StatefulWidget {
  final ModelViewModel modelDetail;
  const ModelUpdate({Key key, this.modelDetail}) : super(key: key);

  @override
  _ModelUpdateState createState() => _ModelUpdateState();
}

class _ModelUpdateState extends State<ModelUpdate> {
  DateTime _date;
  int genderController;
  TextEditingController nameController,
      dobController,
      phoneController,
      addressController,
      giftedController;

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
    nameController = TextEditingController()..text = widget.modelDetail.name;
    genderController = widget.modelDetail.gender;
    dobController = TextEditingController()
      ..text = formatDate(widget.modelDetail.dateOfBirth);
    phoneController = TextEditingController()..text = widget.modelDetail.phone;
    addressController = TextEditingController()
      ..text = widget.modelDetail.subAddress;
    giftedController = TextEditingController()
      ..text = widget.modelDetail.gifted;
    _date = DateTime.parse(widget.modelDetail.dateOfBirth);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Name',
                // suffixIcon: Icon(
                //   Icons.check_circle,
                // ),
              ),
            ),
            DropdownButtonFormField(
              value: genderController,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Gender',
                // suffixIcon: Icon(
                //   Icons.check_circle,
                // ),
              ),
              items: [
                DropdownMenuItem(
                  child: Text("Male"),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text("Female"),
                  value: 1,
                )
              ],
              onChanged: (int value) {
                setState(() {
                  genderController = value;
                });
              },
            ),
            TextFormField(
              controller: dobController,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Date of birth',
                // suffixIcon: Icon(
                //   Icons.check_circle,
                // ),
              ),
            ),
            ElevatedButton.icon(
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
            TextFormField(
              cursorColor: kPrimaryColor,
              controller: phoneController,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Phone number',
                // suffixIcon: Icon(
                //   Icons.check_circle,
                // ),
              ),
            ),
            TextFormField(
                cursorColor: kPrimaryColor,
                controller: addressController,
                decoration: InputDecoration(
                  icon: Icon(Icons.drive_file_rename_outline),
                  labelText: 'Address',
                  // suffixIcon: Icon(
                  //   Icons.check_circle,
                  // ),
                )),
            TextFormField(
                cursorColor: kPrimaryColor,
                controller: giftedController,
                decoration: InputDecoration(
                  icon: Icon(Icons.drive_file_rename_outline),
                  labelText: 'Gifted',
                  // suffixIcon: Icon(
                  //   Icons.check_circle,
                  // ),
                )),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Text('UPDATE'),
              onPressed: () async {
                Map<String, dynamic> params = Map<String, dynamic>();
                params['id'] = widget.modelDetail.id;
                params['name'] = nameController.text;
                params['gender'] = genderController;
                params['dateOfBirth'] = _date.toString();
                params['subAddress'] = addressController.text;
                params['phone'] = phoneController.text;
                params['gifted'] = giftedController.text;
                await Provider.of<ModelViewModel>(context, listen: false)
                    .updateProfileModel(params);
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_) =>
                //         ChangeNotifierProvider<ModelViewModel>.value(
                //             value: widget.modelDetail,
                //             child: ModelProfilePage(
                //                 modelId: widget.modelDetail.id))));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                        MainScreen(page: 4),
                  )
                );
              },
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                elevation: 0,
                minimumSize: Size(10, 50),
              ),
            ),
          ],
        ));
  }
}
