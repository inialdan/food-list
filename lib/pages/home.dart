import 'package:flutter/material.dart';

import 'package:food_app/common/utils.dart';
import 'package:food_app/providers/food_provider.dart';
import 'package:food_app/widgets/custom_appbar.dart';
import 'package:food_app/widgets/custom_drawer.dart';
import 'package:food_app/widgets/food_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    return SafeArea(
      child: Scaffold(
        key: _drawerKey,
        drawer: CustomDrawer(),
        appBar: AppBarDrawer(
          title: "Home Page",
          drawerKey: _drawerKey,
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/add');
          },
          child: Container(
            padding: EdgeInsets.all(10),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor.withOpacity(.26),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor,
              ),
              child: Icon(Icons.add),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Simple way to find \nTasty food",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kBorderColor),
                ),
                child: Icon(Icons.search),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: foodProvider.getFoods,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return FoodCard(snapshot: snapshot);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
