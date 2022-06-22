import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

final StellarSDK sdk = StellarSDK.TESTNET;
final network = Network.TESTNET;

class QR_Generated_Screen extends StatefulWidget {
  const QR_Generated_Screen({Key? key, required this.publicKey})
      : super(key: key);
  final String publicKey;

  @override
  _QR_Generated_ScreenState createState() => _QR_Generated_ScreenState();
}

class _QR_Generated_ScreenState extends State<QR_Generated_Screen> {
  ScreenshotController screenshotController = ScreenshotController();
  late Uint8List _imageFile;

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
                  "QR Generated",
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
              Screenshot(
                controller: screenshotController,
                child: QrImage(
                  data: widget.publicKey,
                  version: QrVersions.auto,
                  size: 200.0,
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
              // Container(
              //     height: 50,
              //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              //     child: ElevatedButton(
              //         child: const Text('Print QR Code'),
              //         onPressed: () async {
              //           // await screenshotController
              //           //     .capture(delay: const Duration(milliseconds: 10))
              //           //     .then((Uint8List? image) async {
              //           //   if (image != null) {
              //           //     final directory =
              //           //         await getApplicationDocumentsDirectory();
              //           //     final imagePath =
              //           //         await File('${directory.path}/image.png')
              //           //             .create();
              //           //     await imagePath.writeAsBytes(image);
              //           //
              //           //     /// Share Plugin
              //           //     await Share.shareFiles([imagePath.path]);
              //           //   }
              //           // });
              //         })),
            ],
          ),
        ),
      ),
    );
  }
}
// void _printDocument() {
//   Printing.layoutPdf(
//       onLayout: (pageFormat) async {
//         final doc = pw.Document();
//         final imageProvider = FileImage(_imageFile);
//         final PdfImage image = await pdfImageFromImageProvider(
//             pdf: doc.document, image: imageProvider);
//
//         doc.addPage(
//           pw.Page(
//             pageFormat: PdfPageFormat.a4,
//             build: (pw.Context context) => pw.Center(
//               child: pw.Image(image),
//             ),
//           ),
//         );
//
//         return doc.save();
//       },
//       name: 'Menuwale QR Code');
// }
