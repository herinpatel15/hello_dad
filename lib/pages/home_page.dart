import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_dad/controller/main_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  MainControler mc = Get.put(MainControler());

  final sariController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Vishwa Creation',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Sari',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextField(
                          controller: sariController,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          style: TextField.materialMisspelledTextStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          style: TextField.materialMisspelledTextStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  mc.addData(sariController.text, priceController.text);
                  sariController.text = "";
                },
                child: const Text('Add')),
            const SizedBox(
              height: 10,
            ),
            Obx(() => Text(
                  'Total : ${mc.totalDayTotal}₹',
                  style: const TextStyle(fontSize: 25),
                )),
            const SizedBox(
              height: 10,
            ),
            Obx(() => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: mc.mainData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: IconButton(
                          onPressed: () {
                            _showConfirmationDialog(context, index);
                          },
                          icon: const Icon(Icons.delete)),
                      title: Text(
                          '${mc.mainData[index].sari} x ${mc.mainData[index].price}'),
                      trailing: Text(
                        '${mc.mainData[index].dayTotal}₹',
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to remove item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // Perform the action you want to confirm here
                // For example, you can call a function to delete something
                // deleteItem();
                mc.removeData(index);
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
