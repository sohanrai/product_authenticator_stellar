import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

final _firestore = Firestore.instance;

class QRScanned {
  final String qrText;
  final QRViewController qrController;
  Function callback;
  Function resume;

  QRScanned({this.qrText, this.qrController, this.callback, this.resume});

  RestaurantData restaurantData;

  void getData() async {
    qrController.pauseCamera();

    DocumentSnapshot restaurant =
        await _firestore.collection("restaurants").document(qrText).get();

    if (restaurant.data != null) {
      final restaurantName = restaurant.data['name'];
      final restaurantLocation = restaurant.data['location'];
      final restaurantMenuID = restaurant.data['menuID'];
      final restaurantLogo = restaurant.data['logo'];
      final categoryList = restaurant.data['category'];

      restaurantData = RestaurantData(
          name: restaurantName,
          location: restaurantLocation,
          logo: restaurantLogo,
          menuID: restaurantMenuID,
          categoryList: categoryList);
    }

    if (restaurantData != null)
      callback(restaurantData.categoryList, restaurantData.name,
          restaurantData.logo);
    else {
      BotToast.showText(
        text: "Invalid QR Scanned",
        duration: Duration(seconds: 3),
      );
      resume();
    }
  }
}

class RestaurantData {
  RestaurantData(
      {this.name, this.location, this.logo, this.menuID, this.categoryList});

  final String name;
  final String location;
  final String logo;
  final String menuID;
  final categoryList;
}
