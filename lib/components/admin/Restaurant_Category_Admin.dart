import 'package:async_loader/async_loader.dart';
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
import 'Category_Card_Admin.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

final _firestore = Firestore.instance;
List categoryList;

String restaurantLogo;
File _image;
final categoryNameEdit = TextEditingController();
final _formKey = GlobalKey<FormState>();
final GlobalKey<AsyncLoaderState> _asyncLoaderState =
    new GlobalKey<AsyncLoaderState>();

class RestaurantCategoryAdminStream extends StatelessWidget {
  final FirebaseUser currentUser = FirebaseData.currentUser;
  static void refreshCategory() {
    _asyncLoaderState.currentState.reloadState();
  }

  Future _getRestaurantData() async {
    DocumentSnapshot restaurant = await _firestore
        .collection("restaurants")
        .document(currentUser.uid)
        .get();

    if (restaurant.data != null) {
      categoryList = restaurant.data['category'];
    }
  }

  @override
  Widget build(BuildContext context) {
    Future uploadFile() async {
      context.showLoaderOverlay();
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('Restaurant_Category_Images/${Path.basename(_image.path)}}');
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      await storageReference.getDownloadURL().then((fileURL) {
        restaurantLogo = fileURL;
      });
    }

    var _asyncLoader = AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await _getRestaurantData(),
        renderLoad: () => Expanded(
                child: Center(
                    child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(AppColors.yellow),
            ))),
        renderError: ([error]) => Text('Error Loading, Please Try Again.'),
        renderSuccess: ({data}) {
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
          } else {
            List<CategoryCardAdmin> categoryCards = [];
            for (var category in categoryList) {
              final categoryName = category['name'];
              final categoryImage = category['image'];
              final categoryItems = category['items'];
              final categoryCard = CategoryCardAdmin(
                categoryName: categoryName,
                key: ValueKey(categoryName),
                categoryImage: categoryImage,
                categoryItems: categoryItems,
                delete: (name, url) {
                  categoryCards
                      .removeWhere((category) => category.categoryName == name);

                  List updatedCategory = [];

                  for (var category in categoryCards) {
                    updatedCategory.add({
                      "image": category.categoryImage,
                      "name": category.categoryName,
                      "items": category.categoryItems == null
                          ? []
                          : category.categoryItems,
                    });
                  }

                  final batch = Firestore.instance.batch();
                  batch.updateData(
                      _firestore
                          .collection("restaurants")
                          .document(currentUser.uid),
                      {"category": updatedCategory});
                  batch.commit();

                  FirebaseStorage.instance
                      .getReferenceFromUrl(url)
                      .then((reference) => reference.delete())
                      .catchError((e) => print(e));

                  refreshCategory();
                },
                edit: (categoryName) {
                  categoryNameEdit.text = categoryName;
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
                                height: 350.0,
                                width: double.infinity,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      AppTextFields(
                                        validator: Validators.nameValidator,
                                        controller: categoryNameEdit,
                                        text: 'Category Name',
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text('Category Image'),
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
                                                imageURL: categoryImage,
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
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();

                                            if (_image != null)
                                              await uploadFile();

                                            category = categoryList.firstWhere(
                                                (category) =>
                                                    category['name'] ==
                                                    categoryName);

                                            category['name'] =
                                                categoryNameEdit.text;
                                            if (_image != null)
                                              category['image'] =
                                                  restaurantLogo;
                                            final batch =
                                                Firestore.instance.batch();
                                            batch.updateData(
                                                _firestore
                                                    .collection("restaurants")
                                                    .document(currentUser.uid),
                                                {"category": categoryList});
                                            batch.commit();
                                            refreshCategory();
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

              categoryCards.add(categoryCard);
            }
            return Expanded(
              child: ReorderableListView(
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) newIndex -= 1;
                  categoryCards.insert(
                      newIndex, categoryCards.removeAt(oldIndex));
                  List updatedCategory = [];

                  for (var category in categoryCards) {
                    updatedCategory.add({
                      "image": category.categoryImage,
                      "name": category.categoryName,
                      "items": category.categoryItems == null
                          ? []
                          : category.categoryItems,
                    });
                  }

                  final batch = Firestore.instance.batch();
                  batch.updateData(
                      _firestore
                          .collection("restaurants")
                          .document(currentUser.uid),
                      {"category": updatedCategory});
                  batch.commit();
                },
                padding: EdgeInsets.only(top: 20.0),
                children: categoryCards,
              ),
            );
          }
        });

    return _asyncLoader;
  }
}
