import 'package:flutter/material.dart';
import 'package:qrcode_reader/models/scan_model.dart';
import 'package:qrcode_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DbProvider.instance.nuevoScan(nuevoScan);
    nuevoScan.id = id;

    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScans() async {
    this.scans = [];
    final scans = await DbProvider.instance.getScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansTipo(String tipo) async {
    this.scans = [];
    final scans = await DbProvider.instance.getScansType(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DbProvider.instance.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  borrarScanId(int id) async {
    await DbProvider.instance.deleteScan(id);
    cargarScansTipo(this.tipoSeleccionado);
    // notifyListeners();
  }
}
