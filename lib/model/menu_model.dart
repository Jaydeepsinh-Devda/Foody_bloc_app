enum MenuCategory { food, beverage }

class MenuModel {
  final int id;
  final MenuCategory menuCategory;
  final String itemName;
  final int itemPrice;
  int itemQuantity;

  MenuModel({
    required this.id,
    required this.menuCategory,
    required this.itemName,
    required this.itemPrice,
    this.itemQuantity = 0,
  });
}
