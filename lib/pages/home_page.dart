import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'atur_suhu.dart';
import '../providers/datas.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Initial data fetch
    Provider.of<Datas>(context, listen: false).initialData();

    // Set up a timer to refresh every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        // Check if the widget is still mounted before calling setState
        Provider.of<Datas>(context, listen: false).initialData();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eco Care"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Remove the manual refresh and rely on the automatic refresh every 5 seconds
              // monitor.initialData().then((value) {
              //   setState(() {});
              // });
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<Datas>(
          builder: (context, monitor, _) {
            return monitor.jumlahData == 0
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      const SizedBox(height: 100),
                      Text(
                        "Derajat: ${monitor.allData[0].derajat}",
                        style: const TextStyle(fontSize: 50),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "PH: ${monitor.allData[0].ph}",
                        style: const TextStyle(fontSize: 50),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Heater Speed: ${monitor.allData[0].heater_speed} RPM - Cooling Speed: ${monitor.allData[0].cooling_speed} RPM",
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AturSuhu.routeName,
                            arguments: monitor.allData[0].id,
                          );
                        },
                        child: const Text("Atur Suhu"),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
