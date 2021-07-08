import 'package:fero/components/casting_card.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastingNotificationPage extends StatelessWidget {
  final List<int> castings;
  const CastingNotificationPage({Key key, this.castings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Casting List'),
        ),
      
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: SizedBox(
                height: height - 162,
                child: FutureBuilder<CastingListViewModel>(
                    future: Provider.of<CastingListViewModel>(context,
                            listen: false)
                        .castingByIds(castings),
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
                          return Center(
                            child: SizedBox(
                              child:
                                  Text('You haven\'t applied to any casting'),
                            ),
                          );
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
