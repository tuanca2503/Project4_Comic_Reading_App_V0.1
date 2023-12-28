import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  //
  // Barcode? result;
  // QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return bodyQRScanScreen();
  }

  Widget bodyQRScanScreen() {
    return Container(
      color: Colors.amber,
      child: const Column(
        children: <Widget>[
          // Expanded(
          //   flex: 5,
          //   child: QRView(
          //     key: qrKey,
          //     onQRViewCreated: _onQRViewCreated,
          //   ),
          // ),
          // Text('Scan result: ${result?.code}'),
        ],
      ),
    );
  }
//

// void _onQRViewCreated(QRViewController controller) {
//   this.controller = controller;
//   controller.scannedDataStream.listen((scanData) {
//     setState(() {
//       result = scanData;
//     });
//   });
// }

// @override
// void dispose() {
//   controller?.dispose();
//   super.dispose();
// }

////////////////////////////////////////////////////////////
}
