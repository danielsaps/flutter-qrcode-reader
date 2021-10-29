import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_reader/models/scan_model.dart';
import 'package:qrcode_reader/pages/direcciones_page.dart';
import 'package:qrcode_reader/pages/mapas_page.dart';
import 'package:qrcode_reader/providers/db_provider.dart';
import 'package:qrcode_reader/providers/scan_list_provider.dart';
import 'package:qrcode_reader/providers/ui_provider.dart';
import 'package:qrcode_reader/widgets/custom_navigationbar.dart';
import 'package:qrcode_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {
              final scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false);

              scanListProvider.borrarTodos();
            },
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;
    // final tempScan =
    //     new ScanModel(id: 3, tipo: 'http', valor: 'http://google.com');
    // DbProvider.instance.nuevoScan(tempScan);
    // DbProvider.instance.getScans().then((value) => print(value));
    // DbProvider.instance.deleteAllScan();

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansTipo('geo');
        return MapasPage();
      case 1:
        scanListProvider.cargarScansTipo('http');
        return DireccionesPage();
      default:
        // scanListProvider.cargarScansTipo('geo');
        return MapasPage();
    }
  }
}
