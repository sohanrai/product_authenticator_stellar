import 'package:flutter/material.dart';

import '../models/get_products.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  List<Widget> cards = [];
  getProductsCards() async {
    cards = await getProducts(context);
    setState(() {

    });
  }

  @override
  void initState() {
    getProductsCards();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView(
          children: cards,
        ),
      ),
    );
  }
}
