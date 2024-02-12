import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/datas.dart';
import 'pages/atur_suhu.dart';
import './pages/home_page.dart';

void main() {
  runApp(const EcoCare());
}

class EcoCare extends StatelessWidget {
  const EcoCare({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Datas(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          AturSuhu.routeName: (context) => const AturSuhu(),
        },
      ),
    );
  }
}
