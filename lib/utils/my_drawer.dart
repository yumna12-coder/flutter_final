import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/reusable_widgets/reusable_widget.dart';
import 'package:flutter_final/screens/signin.dart';
import 'package:flutter_final/utils/my_drawer_title.dart';
import 'package:flutter_final/screens/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Padding(
  padding: const EdgeInsets.only(top: 150),
  child: Image.asset(
    "assets/images/quran.png",
    height: 150,  // specify the desired height
    width: 150,   // specify the desired width
    color: Theme.of(context).colorScheme.primary, // optionally apply a color tint
  ),
),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          MyDrawerTitle(
            text: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          MyDrawerTitle(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingPage()
            
            ),
            );},
          ),
          MyDrawerTitle(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignIn()));},
          )
        ],
      ),
    );
  }
}
