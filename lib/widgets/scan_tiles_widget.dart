import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_reader/providers/scan_list_provider.dart';
import 'package:qrcode_reader/utils/utils..dart';

class ScanTileWidget extends StatelessWidget {
  final String tipo;

  const ScanTileWidget({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (BuildContext context, i) => Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (DismissDirection direction) {
          String id = scans[i].id.toString();
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScanId(int.parse(id));
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'http' ? Icons.home : Icons.map,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[i].valor),
          subtitle: Text("${scans[i].id}"),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () {
            final _url = scans[i].valor;
            print('Abriendo $_url');
            launchURL(context, scans[i]);
            // void _launchURL() async => await canLaunch(_url)
            //     ? await launch(_url)
            //     : throw 'Could not launch $_url';
          },
        ),
      ),
    );
  }
}
