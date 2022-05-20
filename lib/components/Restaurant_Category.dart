import 'package:flutter/material.dart';
import 'package:menuwale/models/App_Colors.dart';
import 'Category_Card.dart';

class RestaurantCategoryStream extends StatelessWidget {
  final String searchValue;
  final List categoryList;
  RestaurantCategoryStream(this.searchValue, this.categoryList);

  @override
  Widget build(BuildContext context) {
    if (categoryList == null || categoryList.isEmpty) {
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
              'No Menu',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    List<CategoryCard> categoryCards = [];
    for (var category in categoryList) {
      final categoryName = category['name'];
      final categoryImage = category['image'];
      final categoryItems = category['items'];
      final categoryCard = CategoryCard(
        categoryName: categoryName,
        categoryImage: categoryImage,
        categoryItems: categoryItems,
      );

      categoryCards.add(categoryCard);
    }
    List<CategoryCard> searchedCategory = [];
    if (searchValue != null) {
      searchedCategory = categoryCards
          .where((string) => string.categoryName
              .toLowerCase()
              .contains(searchValue.toLowerCase()))
          .toList();
    } else {
      searchedCategory = categoryCards;
    }

    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.only(top: 20.0),
        children: searchedCategory,
      ),
    );
  }
}
