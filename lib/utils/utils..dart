import 'package:flutter/cupertino.dart';
import 'package:qrcode_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'Could not launch ${scan.valor}';
    }
  } else {
    print('geo');
    Navigator.pushNamed(context, '/mapa', arguments: scan);
  }
}
