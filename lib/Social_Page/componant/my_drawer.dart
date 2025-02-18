import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  //logout function
  void LogOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //DrawerHeader
          DrawerHeader(
            child: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Column(
            children: [
              //home title
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    //this  already in home page
                    Navigator.of(context);
                    //navigate to home page
                    Navigator.of(context).pushNamed('/home');
                  },
                ),
              ),
              //profile title
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('P R O F I L E'),
                  onTap: () {
                    //this  already in home page
                    Navigator.of(context);
                    //navigate to profile page
                    Navigator.of(context).pushNamed('/profile');
                  },
                ),
              ),
              //user title
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.group),
                  title: Text('U S E R S '),
                  onTap: () {
                    //this  already in User page
                    Navigator.of(context);
                    //navigate to user page
                    Navigator.of(context).pushNamed('/user');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap:
                  //this  already in home page
                  //Navigator.of(context);
                  //logout function
                  LogOut,
            ),
          )
        ],
      ),
    );
  }
}
