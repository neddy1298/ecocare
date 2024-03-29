import 'package:ecocare/providers/datas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../providers/datas.dart';

class AturSuhu extends StatelessWidget {
  static const routeName = "/atur-suhu";

  const AturSuhu({super.key});

  @override
  Widget build(BuildContext context) {
    final datas = Provider.of<Datas>(context, listen: false);
    final dataId = ModalRoute.of(context)!.settings.arguments as String;
    final selectData = datas.selectById(dataId);
    final TextEditingController heaterController =
        TextEditingController(text: selectData.heater_speed.toString());
    final TextEditingController coolingController =
        TextEditingController(text: selectData.cooling_speed.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atur Suhu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: const InputDecoration(labelText: "Suhu"),
                textInputAction: TextInputAction.next,
                controller: heaterController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(labelText: "cooling"),
                textInputAction: TextInputAction.next,
                controller: coolingController,
              ),
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    datas.aturSuhu(
                      selectData.id,
                      int.parse(heaterController.text),
                      int.parse(coolingController.text),
                      context,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
