import 'package:flutter/material.dart';

import '../models/get_qr_product.dart';

class QRScannedScreen extends StatefulWidget {
  final String publicKey;
  const QRScannedScreen({Key? key, required this.publicKey}) : super(key: key);

  @override
  _QRScannedScreenState createState() => _QRScannedScreenState();
}

class _QRScannedScreenState extends State<QRScannedScreen> {
  List<Widget> text = [];
  getProductsCards() async {
    if (widget.publicKey.length == 56) {
      text = await getQRProducts(widget.publicKey);
    } else {
      text.add(const Text('Product Not Found'));
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Product Verification'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: text,
        ),
      ),
    );
  }
}
