import 'package:flutter/material.dart';
import 'package:menuwale/models/App_Colors.dart';
import 'package:menuwale/screens/Menu_Items_Screen.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard(
      {this.categoryID,
      this.categoryName,
      this.categoryImage,
      this.categoryItems});

  final int categoryID;
  final String categoryName;
  final String categoryImage;
  final categoryItems;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        print(categoryItems);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MenuItemsScreen(
              itemList: categoryItems,
            ),
          ),
        );
      },
      child: Card(
        elevation: 0.5,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.black,
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.dstATop,
                ),
                image: categoryImage == null
                    ? AssetImage('assets/images/menu_placeholder.jpg')
                    : NetworkImage(
                        categoryImage,
                      ),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Text(
              categoryName.toUpperCase(),
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
