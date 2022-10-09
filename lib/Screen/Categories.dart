import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["Land" , "Residential" , "Commercial" , "Industrial" , "Example1" , "Example2"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child:SizedBox(
          height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context , index) => buildCategory(index),
        ),
        ),
        );
  }
  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedIndex = index;
        });
      },
      child:Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index ? Color(0xFF2196F3) : Color(0xFF000000),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                height: 2,
                width: 30,
                color: selectedIndex == index ? Colors.blue : Colors.transparent ,
              )
            ]
        ),
      ),
    );

  }
}