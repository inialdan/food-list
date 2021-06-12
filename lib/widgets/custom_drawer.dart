import 'package:flutter/material.dart';
import 'package:food_app/providers/food_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<FoodProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/food-app-ff7e9.appspot.com/o/buku%20pelajaran.jpg?alt=media&token=a637b4ca-d9b0-4a21-968f-1412f968cba1'),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(),
          ),
          DrawerItem(
            title: "Dashboard",
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          DrawerItem(
            title: "About",
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
          DrawerItem(
            title: "Profile",
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          DrawerItem(
            title: "Setting",
            onTap: () {
              Navigator.pushNamed(context, '/setting');
            },
          ),
          DrawerItem(
            title: "Log Out",
            onTap: () {
              noteProvider.logout(context);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      onTap: onTap,
    );
  }
}
