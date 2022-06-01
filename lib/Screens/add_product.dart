import 'package:flutter/material.dart';

class add_product extends StatefulWidget {
  const add_product({Key? key}) : super(key: key);

  @override
  _add_productState createState() => _add_productState();
}

class _add_productState extends State<add_product> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 40.0,
            width: 150.0,
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Enter Product Details',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 100.0,
            width: 150.0,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Product Title',
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
            width: 150.0,
            child: Divider(
              thickness: 0.8,
              color: Colors.white70,
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
                child: const Text('Generate QR Code'), onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
