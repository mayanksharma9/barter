import 'package:flutter/material.dart';

class Ads {
  final String image, title , description , size;
  final int price  , id;

  Ads(
  {
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.description,
    @required this.size,
    @required this.price,
}
      );
}

