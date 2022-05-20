import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menuwale/models/App_Colors.dart';

class ItemCard extends StatelessWidget {
  ItemCard({this.itemID, this.itemName, this.itemImage, this.itemPrice});

  final int itemID;
  final String itemName;
  final String itemImage;
  final itemPrice;

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
//            InkWell(
//              onTap: () {},
//              child: Container(
//                alignment: Alignment.center,
//                width: 25.0,
//                height: 25.0,
//                decoration: BoxDecoration(
//                    color: AppColors.red,
//                    borderRadius: BorderRadius.circular(5.0)),
//                child: Text(
//                  '+',
//                  textAlign: TextAlign.center,
//                  style: TextStyle(fontSize: 20.0, color: AppColors.white),
//                ),
//              ),
//            )
          ],
        ),
      ),
    );
  }
}
