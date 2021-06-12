import 'package:flutter/material.dart';
import 'package:food_app/providers/food_provider.dart';
import 'package:food_app/services/storage.dart';
import 'package:provider/provider.dart';

class AddFoodPage extends StatelessWidget {
  const AddFoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          foodProvider.image =
                              await StorageServices.getImage(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Image.network(
                              foodProvider.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 20,
                        child: InkWell(
                          onTap: () {
                            Navigator.popAndPushNamed(context, '/home');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            foodProvider.title = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nama Makanan",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            foodProvider.detail = value;
                          },
                          maxLines: 24,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Detail Makanan",
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            foodProvider.addFood(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 56.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
