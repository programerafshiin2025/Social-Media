import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPostButton extends StatelessWidget {
  const MyPostButton({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(left: 10),
        child: Center(
          child: Icon(Icons.done,
          color: Theme.of(context).colorScheme.primary,),
        ),
      ),
    );
  }
}
