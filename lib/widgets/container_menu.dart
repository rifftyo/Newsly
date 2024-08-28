import 'package:flutter/material.dart';

Widget containerMenu(String titleMenu, VoidCallback onTap, bool isActive) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        color: isActive ? Colors.blue : Colors.grey[200],
      ),
      width: 150,
      height: 35,
      child: Center(
        child: Text(
          titleMenu,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
    ),
  );
}
