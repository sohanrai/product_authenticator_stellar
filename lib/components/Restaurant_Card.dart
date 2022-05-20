import 'package:flutter/material.dart';
import 'package:menuwale/models/App_Colors.dart';
import 'package:menuwale/screens/Menu_Category_Screen.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard(
      {this.name, this.location, this.logo, this.menuID, this.categoryList});

  final String name;
  final String location;
  final String logo;
  final String menuID;
  final categoryList;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MenuCategoryScreen(
                categoryList: categoryList,
                name: name,
                logo: logo,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50.0,
                child: logo == null
                    ? Image.asset('assets/images/restaurant_placeholder.jpg')
                    : Image.network(logo),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name.toUpperCase(),
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      location == null ? '' : location,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
