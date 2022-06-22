import 'package:flutter/material.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:untitled1/models/create_account.dart';

import 'QR_generated_screen.dart';

final StellarSDK sdk = StellarSDK.TESTNET;
final network = Network.TESTNET;

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dealerController = TextEditingController();
  TextEditingController MRPController = TextEditingController();
  TextEditingController serialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
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
                  controller: serialController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Serial No.',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Model Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: dealerController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Dealer Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: MRPController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'MRP',
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
                    child: const Text('Generate QR Code'),
                    onPressed: () async {
                      var result = await createAccount(
                          sdk: sdk,
                          network: network,
                          serialNo: serialController.text,
                          modelName: titleController.text,
                          dealerName: dealerController.text,
                          MRP: MRPController.text);

                      print(result);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => QR_Generated_Screen(
                                publicKey: result!,
                              )));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
