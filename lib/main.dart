// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_reader/pages/home_page.dart';
import 'package:qrcode_reader/pages/map_page.dart';
import 'package:qrcode_reader/providers/scan_list_provider.dart';
import 'package:qrcode_reader/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new UiProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => new ScanListProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'QR Reader',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
          '/mapa': (BuildContext context) => MapPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
