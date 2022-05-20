import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menuwale/models/App_Colors.dart';
import '../App_Alert.dart';

class ItemCardAdmin extends StatelessWidget {
  ItemCardAdmin(
      {this.itemName,
      this.itemImage,
      this.itemPrice,
      this.key,
      this.delete,
      this.edit});

  final String itemName;
  final String itemImage;
  final itemPrice;
  final key;
  final Function delete;
  final Function edit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Color(0xffE5E5E5),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 50.0,
              child: itemImage == null
                  ? Image.asset('assets/images/menu_placeholder.jpg')
                  : Image.network(
                      itemImage,
                    ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    itemName.toUpperCase(),
                    maxLines: 2,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Text(
                    '₹' + itemPrice.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    edit(itemName, itemPrice);
                  },
                  child: Icon(
                    Icons.edit,
                    size: 20.0,
                    color: AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => AppAlert(
                              titleText: 'Are you sure?',
                              contentText: 'Do you to delete $itemName?',
                              actionText: 'Delete',
                              onPressed: () {
                                delete(itemName, itemImage);
                                Navigator.pop(context);
                              },
                            ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete_forever,
                      size: 20.0,
                      color: AppColors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
