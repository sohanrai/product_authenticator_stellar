import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menuwale/models/App_Colors.dart';
import 'Restaurant_Card.dart';

final _firestore = Firestore.instance;

class RestaurantStream extends StatelessWidget {
  final String searchValue;

  RestaurantStream({
    this.searchValue,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('restaurants').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || searchValue == null || searchValue == '') {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.restaurant_menu,
                  size: 50.0,
                  color: AppColors.iconGrey,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Search Restaurants',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Type restaurant name',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          );
        }
        final restaurants = snapshot.data.documents;
        List<RestaurantCard> restaurantCard = [];
        for (var restaurant in restaurants) {
          final restaurantName = restaurant.data['name'];
          final restaurantLocation = restaurant.data['location'];
          final restaurantMenuID = restaurant.data['menuID'];
          final restaurantLogo = restaurant.data['logo'];
          final categoryList = restaurant.data['category'];

          final restaurantsCard = RestaurantCard(
              name: restaurantName,
              location: restaurantLocation,
              logo: restaurantLogo,
              menuID: restaurantMenuID,
              categoryList: categoryList);

          restaurantCard.add(restaurantsCard);
        }
        List<RestaurantCard> searchedRestaurants = [];

        searchedRestaurants = restaurantCard
            .where((string) =>
                string.name.toLowerCase().contains(searchValue.toLowerCase()))
            .toList();

        if (searchedRestaurants != null && searchedRestaurants.isEmpty) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.clear,
                  size: 50.0,
                  color: AppColors.iconGrey,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'No Restaurant Found',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Please try searching for another restaurant',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 20.0),
            children: searchedRestaurants,
          ),
        );
      },
    );
  }
}
