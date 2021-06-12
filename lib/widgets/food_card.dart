import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food_app/common/utils.dart';
import 'package:food_app/providers/food_provider.dart';
import 'package:provider/provider.dart';

class FoodCard extends StatelessWidget {
  final snapshot;
  FoodCard({
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(10.0),
      crossAxisCount: 2,
      itemCount: snapshot.data.length,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/detail',
              arguments: snapshot.data[index].id,
            );
          },
          child: Container(
            height: 200,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(snapshot.data[index].image),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    snapshot.data[index].title,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'By Food App',
                    style: TextStyle(
                      color: kTextColor.withOpacity(.5),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        foodProvider.deleteFood(
                            snapshot.data[index].id, context);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: snapshot.data[index].id,
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
    );
  }
}
