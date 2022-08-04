import 'package:flutter/material.dart';

class Friend {
  const Friend({
    required this.name,
    this.image,
    this.isBestFriend = false,
  });

  final String name;
  final String? image;
  final bool isBestFriend;
}

class FriendColor {
  const FriendColor({
    required this.primaryColor,
    required this.secondaryColor,
  });

  final Color primaryColor;
  final Color secondaryColor;
}
