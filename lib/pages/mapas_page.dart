import 'package:flutter/material.dart';
import 'package:qrcode_reader/widgets/scan_tiles_widget.dart';

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanTileWidget(tipo: 'geo');
  }
}
