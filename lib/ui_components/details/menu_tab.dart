import 'package:flutter/material.dart';
import 'package:foody_bloc_app/bloc/details/details_bloc.dart';
import 'package:foody_bloc_app/bloc/details/details_event.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/model/menu_model.dart';

class MenuTab extends StatefulWidget {
  final List<MenuModel> foodList;
  final List<MenuModel> beverageList;
  final DetailsBloc bloc;

  const MenuTab({
    required this.foodList,
    required this.beverageList,
    required this.bloc,
    super.key,
  });

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 20),
      child: CustomScrollView(
        slivers: [
          _sliverToBoxAdapter(_foodMenuText()),
          _menuList(widget.foodList),
          _sliverToBoxAdapter(_beverageMenuText()),
          _menuList(widget.beverageList)
        ],
      ),
    );
  }

  Widget _sliverToBoxAdapter(Widget text) => SliverToBoxAdapter(
        child: text,
      );

  Widget _foodMenuText() => Text(
        "${FoodyAppStrings.kFood} ${FoodyAppStrings.kMenu}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _menuList(List<MenuModel> list) => SliverList.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _listCard(index, list);
        },
      );

  Widget _listCard(int index, List<MenuModel> list) => Card(
        color: Colors.white,
        child: ListTile(
          leading: _listLeadingIcon(list, index),
          title: _itemName(index, list),
          subtitle: _itemPrice(index, list),
          trailing: list[index].itemQuantity == 0
              ? _trailingAddButton(index, list)
              : _trailingQuantityCounter(index, list),
        ),
      );

  Widget _listLeadingIcon(List<MenuModel> list, int index) => Icon(
        list[index].menuCategory.name == FoodyAppStrings.kFood.toLowerCase()
            ? Icons.food_bank
            : Icons.local_drink_rounded,
        color: Colors.red,
      );

  Widget _itemName(int index, List<MenuModel> list) => Text(
        list[index].itemName,
        style: const TextStyle(fontSize: 12),
      );

  Widget _itemPrice(int index, List<MenuModel> list) => Text(
        "${FoodyAppStrings.kINR} ${list[index].itemPrice.toStringAsFixed(2)}",
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _trailingQuantityCounter(int index, List<MenuModel> list) => SizedBox(
        width: 105,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                widget.bloc.add(
                  ItemQuantityIncreaseAndDecreaseEvent(
                      id: list[index].id,
                      isIncrease: false,
                      isFood: list[index].menuCategory.name ==
                          FoodyAppStrings.kFood.toLowerCase()),
                );
              },
              icon: const Icon(Icons.remove),
            ),
            Text("${list[index].itemQuantity}"),
            IconButton(
              onPressed: () {
                widget.bloc.add(
                  ItemQuantityIncreaseAndDecreaseEvent(
                      id: list[index].id,
                      isIncrease: true,
                      isFood: list[index].menuCategory.name ==
                          FoodyAppStrings.kFood.toLowerCase()),
                );
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
      );

  Widget _trailingAddButton(int index, List<MenuModel> list) => OutlinedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.red),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: () {
          widget.bloc.add(
            ItemQuantityIncreaseAndDecreaseEvent(
                id: list[index].id,
                isIncrease: true,
                isFood: list[index].menuCategory.name ==
                    FoodyAppStrings.kFood.toLowerCase()),
          );
        },
        child: Text(FoodyAppStrings.kAdd),
      );

  Widget _beverageMenuText() => Text(
        "${FoodyAppStrings.kBeverage} ${FoodyAppStrings.kMenu}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );
}
