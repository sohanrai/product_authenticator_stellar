import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_selector_formfield/image_selector_formfield.dart';
import 'package:menuwale/models/App_Colors.dart';
import 'package:menuwale/models/FirebaseData.dart';
import 'package:menuwale/models/validators.dart';
import '../App_Text_Fields.dart';
import '../Buttons.dart';
import 'Item_Card_Admin.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

import 'Restaurant_Category_Admin.dart';

final FirebaseUser currentUser = FirebaseData.currentUser;

final _firestore = Firestore.instance;
List itemList;

String uploadedItemImageURL;
File _image;
final itemNameEdit = TextEditingController();
final itemPriceEdit = TextEditingController();
final _formKey = GlobalKey<FormState>();

class RestaurantItemAdminStream extends StatelessWidget {
  RestaurantItemAdminStream(
      {this.items, this.categoryList, this.categoryName, this.updateItems});

  final items;
  final categoryList;
  final categoryName;
  final Function updateItems;

  @override
  Widget build(BuildContext context) {
    itemList = items;

    Future uploadFile() async {
      context.showLoaderOverlay();
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('Restaurant_Items_Images/${Path.basename(_image.path)}}');
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      await storageReference.getDownloadURL().then((fileURL) {
        uploadedItemImageURL = fileURL;
      });
    }

    if (itemList == null) {
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
    } else {
      List<ItemCardAdmin> itemCards = [];
      for (var item in itemList) {
        final itemName = item['name'];
        final itemImage = item['image'];
        final itemPrice = item['price'];
        final itemCard = ItemCardAdmin(
          itemName: itemName,
          key: ValueKey(itemName),
          itemImage: itemImage,
          itemPrice: itemPrice,
          delete: (name, url) {
            itemList.removeWhere((item) => item['name'] == itemName);

            final category = categoryList
                .firstWhere((category) => category['name'] == categoryName);

            category['items'] = itemList;

            final batch = Firestore.instance.batch();
            batch.updateData(
                _firestore.collection("restaurants").document(currentUser.uid),
                {"category": categoryList});
            batch.commit();

            FirebaseStorage.instance
                .getReferenceFromUrl(url)
                .then((reference) => reference.delete())
                .catchError((e) => null);

            updateItems();
          },
          edit: (itemName, itemPrice) {
            itemNameEdit.text = itemName;
            itemPriceEdit.text = itemPrice;
            showModalBottomSheet(
                isScrollControlled: true,
                barrierColor: Colors.black.withOpacity(0.5),
                backgroundColor: AppColors.white,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                builder: (context) => Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                          padding: EdgeInsets.all(40.0),
                          height: 400.0,
                          width: double.infinity,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                AppTextFields(
                                  validator: Validators.nameValidator,
                                  controller: itemNameEdit,
                                  text: 'Item Name',
                                ),
                                AppTextFields(
                                  validator: (value) => value.length < 1
                                      ? 'Please Enter Price'
                                      : null,
                                  controller: itemPriceEdit,
                                  text: 'Item Price',
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Item Image'),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      child: ImageSelectorFormField(
                                          backgroundColor: AppColors.red,
                                          cropRatioX: 9,
                                          cropRatioY: 9,
                                          borderRadius: 10.0,
                                          imageURL: itemImage,
                                          icon: Icon(
                                            Icons.add_photo_alternate,
                                            size: 25,
                                            color: AppColors.white,
                                          ),
                                          onSaved: (img) {
                                            _image = img;
                                          }),
                                    )
                                  ],
                                ),
                                AppSmallButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

                                      if (_image != null) await uploadFile();

                                      item = itemList.firstWhere(
                                          (item) => item['name'] == itemName);

                                      item['name'] = itemNameEdit.text;
                                      item['price'] = itemPriceEdit.text;
                                      if (_image != null)
                                        item['image'] = uploadedItemImageURL;

                                      final category = categoryList.firstWhere(
                                          (category) =>
                                              category['name'] == categoryName);

                                      category['items'] = item;

                                      final batch = Firestore.instance.batch();
                                      batch.updateData(
                                          _firestore
                                              .collection("restaurants")
                                              .document(currentUser.uid),
                                          {"category": categoryList});
                                      batch.commit();
                                      updateItems();
                                      context.hideLoaderOverlay();

                                      Navigator.pop(context);
                                    }
                                  },
                                  text: 'Update',
                                ),
                              ],
                            ),
                          )),
                    ));
          },
        );

        itemCards.add(itemCard);
      }
      return Expanded(
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) newIndex -= 1;
            itemCards.insert(newIndex, itemCards.removeAt(oldIndex));

            final category = categoryList
                .firstWhere((category) => category['name'] == categoryName);

            List updatedItem = [];

            for (var item in itemCards) {
              updatedItem.add({
                "image": item.itemImage,
                "name": item.itemName,
                "price": item.itemPrice
              });
            }
            category['items'] = updatedItem;

            final batch = Firestore.instance.batch();
            batch.updateData(
                _firestore.collection("restaurants").document(currentUser.uid),
                {"category": categoryList});
            batch.commit();
            RestaurantCategoryAdminStream.refreshCategory();
          },
          children: itemCards,
        ),
      );
    }
  }
}
