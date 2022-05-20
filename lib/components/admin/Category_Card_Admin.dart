import 'package:flutter/material.dart';
import 'package:menuwale/components/admin/Restaurant_Category_Admin.dart';
import 'package:menuwale/models/App_Colors.dart';
import 'package:menuwale/screens/admin/Add_Menu_Items_Screen.dart';
import '../App_Alert.dart';

class CategoryCardAdmin extends StatelessWidget {
  CategoryCardAdmin(
      {this.categoryName,
      this.categoryImage,
      this.categoryItems,
      this.key,
      this.delete,
      this.edit});

  final String categoryName;
  final String categoryImage;
  final List categoryItems;
  final key;
  final Function delete;
  final Function edit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddMenuItemsScreen(
                  items: categoryItems,
                  categoryName: categoryName,
                  categoryList: categoryList,
                )));
      },
      child: Card(
        elevation: 0.5,
        child: Container(
          height: 80.0,
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
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    categoryName.toUpperCase(),
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      color: AppColors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          edit(categoryName);
                        },
                        child: Icon(
                          Icons.edit,
                          size: 20.0,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => AppAlert(
                              titleText: 'Are you sure?',
                              contentText: 'Do you to delete $categoryName?',
                              actionText: 'Delete',
                              onPressed: () {
                                delete(categoryName, categoryImage);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete_forever,
                            size: 20.0,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
