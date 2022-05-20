import 'package:flutter/material.dart';
import 'package:menuwale/models/App_Colors.dart';
import 'Item_Card.dart';

class RestaurantItemStream extends StatelessWidget {
  final String searchValue;
  final List itemList;
  RestaurantItemStream(this.searchValue, this.itemList);

  @override
  Widget build(BuildContext context) {
    if (itemList == null || itemList.isEmpty) {
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
              'No Items',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    List<ItemCard> itemCards = [];
    for (var item in itemList) {
      final itemName = item['name'];
      final itemImage = item['image'];
      final itemPrice = item['price'];
      final itemCard = ItemCard(
        itemName: itemName,
        itemImage: itemImage,
        itemPrice: itemPrice,
      );

      itemCards.add(itemCard);
    }
    List<ItemCard> searchedItem = [];
    if (searchValue != null) {
      searchedItem = itemCards
          .where((string) =>
              string.itemName.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
    } else {
      searchedItem = itemCards;
    }

    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(top: 20.0),
        children: searchedItem,
      ),
    );
  }
}
