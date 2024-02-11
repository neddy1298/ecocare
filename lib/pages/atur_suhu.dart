import 'package:ecocare/providers/datas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../providers/datas.dart';

class AturSuhu extends StatelessWidget {
  static const routeName = "/detail-player";

  const AturSuhu({super.key});

  @override
  Widget build(BuildContext context) {
    final datas = Provider.of<Datas>(context, listen: false);
    final dataId = ModalRoute.of(context)!.settings.arguments as String;
    final selectData = datas.selectById(dataId);
    final TextEditingController derajatController =
        TextEditingController(text: selectData.derajat.toString());
    final TextEditingController phController =
        TextEditingController(text: selectData.ph.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("DETAIL PLAYER"),
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
                controller: derajatController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(labelText: "Ph"),
                textInputAction: TextInputAction.next,
                controller: phController,
              ),
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    datas.aturSuhu(
                      dataId,
                      derajatController.text as int,
                      phController.text as int,
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
