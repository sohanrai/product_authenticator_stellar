import 'package:flutter/material.dart';
import 'package:untitled1/Screens/add_product.dart';

class second_screen extends StatefulWidget {
  const second_screen({Key? key}) : super(key: key);

  @override
  _second_screenState createState() => _second_screenState();
}

class _second_screenState extends State<second_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                width: 100.0,
                color: Colors.white,
                child: Image.asset("images/plus.png"),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => add_product()),
                );
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Add Product',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 17.0,
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            GestureDetector(
              child: Container(
                width: 100.0,
                color: Colors.white,
                child: Image.asset("images/listi.png"),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'All Products',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 17.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
