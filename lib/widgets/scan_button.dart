import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qrcode_reader/providers/scan_list_provider.dart';
import 'package:qrcode_reader/utils/utils..dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //   '#3D8BEF',
        //   'Cancelar',
        //   false,
        //   ScanMode.QR,
        // );

        // final barcodeScanRes = 'https://www.google.com/';
        final barcodeScanRes = 'geo:18.1089299,-92.8676013';

        if (barcodeScanRes == '-1') {
          return;
        }

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        print(barcodeScanRes);
        launchURL(context, nuevoScan);
      },
      child: Icon(Icons.filter_center_focus),
    );
  }
}
