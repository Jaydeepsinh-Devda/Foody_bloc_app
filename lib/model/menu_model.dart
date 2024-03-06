enum MenuCategory { food, beverage }

class MenuModel {
  final int id;
  final MenuCategory menuCategory;
  final String itemName;
  final double itemPrice;
  final int itemQuantity;

  MenuModel({
    required this.id,
    required this.menuCategory,
    required this.itemName,
    required this.itemPrice,
    this.itemQuantity = 0,
  });

  MenuModel copyWith({int Function()? itemQuantity}) {
    return MenuModel(
      id: id,
      menuCategory: menuCategory,
      itemName: itemName,
      itemPrice: itemPrice,
      itemQuantity: itemQuantity != null ? itemQuantity() : this.itemQuantity,
    );
  }
}
