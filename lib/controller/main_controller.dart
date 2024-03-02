import 'package:get/get.dart';

class MainControler extends GetxController {
  RxList<ItemData> mainData = <ItemData>[].obs;
  RxDouble totalDayTotal = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    mainData.listen((_) {
      totalDayTotal.value = mainData.fold<double>(
        0.0,
        (sum, item) => sum + item.dayTotal,
      );
    });
  }

  void removeData(index) {
    mainData.removeAt(index);
  }

  void addData(sari, price) {
    ItemData myItem = ItemData(
        sari: int.parse(sari),
        price: double.parse(price),
        dayTotal: int.parse(sari) * double.parse(price));

    mainData.add(myItem);
  }
}

class ItemData {
  int sari;
  double price;
  double dayTotal;

  ItemData({required this.sari, required this.price, required this.dayTotal});
}
