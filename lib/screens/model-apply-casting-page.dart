import 'package:fero/screens/casting-detail-page.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelApplyCastingPage extends StatelessWidget {
  const ModelApplyCastingPage({Key key}) : super(key: key);

  @override
Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Apply List'),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.search),
        //   backgroundColor: kPrimaryColor,
        //   onPressed: () => {
        //     _showDialog(context),
        //   },
        // ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: SizedBox(
                height: height - 90,
                child: FutureBuilder<CastingListViewModel>(
                    future: Provider.of<CastingListViewModel>(context,
                            listen: false)
                        .modelApplyCasting(),
                    builder: (context, data) {
                      if (data.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 150,
                            ),
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      } else {
                        if (data.error == null) {
                          return Consumer<CastingListViewModel>(
                              builder: (ctx, data, child) =>
                                  CastingListComponent(
                                    list: data,
                                  ));
                        } else {
                          return Center(child: SizedBox(child: Text('You haven\'t applied to any casting'),),);
                        }
                      }
                    }),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class CastingListComponent extends StatelessWidget {
  final CastingListViewModel list;
  const CastingListComponent({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.castings.length,
      itemBuilder: (context, index) {
        return CastingCard(casting: list.castings[index]);
      },
    );
  }
}

class CastingCard extends StatelessWidget {
  final CastingViewModel casting;
  const CastingCard({Key key, this.casting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (_) => CastingListViewModel()),
                      ],
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          return CastingDetailPage(
                            casting: casting,
                          );
                        },
                      ))),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor,
                offset: Offset(0, 5),
                blurRadius: 10,
              )
            ]),
        child: Column(
          children: <Widget>[
            Text(casting.name),
            Text(casting.openTime),
            Text(casting.closeTime),
            Text(casting.customerName),
            Text(casting.description),
            Text(casting.salary.toString()),
          ],
        ),
      ),
    );
  }
}

// void _showDialog(BuildContext context) {
//   TextEditingController nameController, minController, maxController;
//   nameController = TextEditingController()..text = '';
//   minController = TextEditingController()..text = '';
//   maxController = TextEditingController()..text = '';
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: new Text("Search"),
//         content: Builder(
//           builder: (context) {
//             // Get available height and width of the build area of this widget. Make a choice depending on the size.
//             // var height = MediaQuery.of(context).size.height;
//             // var width = MediaQuery.of(context).size.width;
//             return Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               height: 180,
//               width: 350,
//               child: ListView(
//                 children: [
//                   TextFormField(
//                     cursorColor: kPrimaryColor,
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       icon: Icon(Icons.drive_file_rename_outline),
//                       labelText: 'Name',
//                     ),
//                   ),
//                   TextFormField(
//                     cursorColor: kPrimaryColor,
//                     controller: minController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       icon: Icon(Icons.drive_file_rename_outline),
//                       labelText: 'Min salary',
//                     ),
//                   ),
//                   TextFormField(
//                     cursorColor: kPrimaryColor,
//                     controller: maxController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       icon: Icon(Icons.drive_file_rename_outline),
//                       labelText: 'Max salary',
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//         actions: <Widget>[
//           ElevatedButton(
//             child: const Text(
//               'Cancel',
//               style: TextStyle(color: Colors.grey),
//             ),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.white,
//               elevation: 0,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           ElevatedButton(
//             child: const Text(
//               'Search',
//               style: TextStyle(color: kPrimaryColor),
//             ),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.white,
//               elevation: 0,
//             ),
//             onPressed: () async {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => MultiProvider(
//                             providers: [
//                               ChangeNotifierProvider(
//                                   create: (_) => CastingListViewModel()),
//                             ],
//                             child: FutureBuilder(
//                               builder: (context, snapshot) {
//                                 return SearchCastingPage(
//                                   name: nameController.text.toString(),
//                                   min: minController.text.toString(),
//                                   max: maxController.text.toString(),
//                                 );
//                               },
//                             ))),
//               );
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
