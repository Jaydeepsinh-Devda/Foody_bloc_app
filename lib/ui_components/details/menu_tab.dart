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
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 20),
      child: CustomScrollView(
        slivers: [
          _sliverToBoxAdapter(_foodMenuText()),
          _foodMenuList(),
          _sliverToBoxAdapter(_beverageMenuText()),
          _beverageMenuList()
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

  Widget _foodMenuList() => SliverList.builder(
        itemCount: widget.foodList.length,
        itemBuilder: (context, index) {
          return _foodListCard(index);
        },
      );

  Widget _foodListCard(int index) => Card(
        color: Colors.white,
        child: ListTile(
          leading: _foodListLeadingIcon(),
          title: _foodName(index),
          subtitle: _foodPrice(index),
          trailing:
              widget.foodList[index].itemQuantity == 0 ? _trailingAddButton() : _trailingQuantityCounter(index),
        ),
      );

  Widget _foodListLeadingIcon() => const Icon(
        Icons.food_bank,
        color: Colors.red,
      );

  Widget _foodName(int index) => Text(
        widget.foodList[index].itemName,
        style: const TextStyle(fontSize: 12),
      );

  Widget _foodPrice(int index) => Text(
        "${FoodyAppStrings.kINR} ${widget.foodList[index].itemPrice.toString()}",
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      );

  Widget _trailingQuantityCounter(int index) => SizedBox(
        width: 105,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                widget.bloc.add(ItemQuantityIncreaseAndDecreaseEvent(
                    id: count, isIncrease: false));
              },
              icon: const Icon(Icons.remove),
            ),
            Text("${widget.foodList[index].itemQuantity}"),
            IconButton(
              onPressed: () {
                widget.bloc.add(ItemQuantityIncreaseAndDecreaseEvent(
                    id: count, isIncrease: true));
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
      );

  Widget _trailingAddButton() => OutlinedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.red),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: () {
          widget.bloc.add(ItemQuantityIncreaseAndDecreaseEvent(
              id: count, isIncrease: true));
        },
        child: Text(FoodyAppStrings.kAdd),
      );

  Widget _beverageMenuList() => SliverList.builder(
        itemCount: widget.beverageList.length,
        itemBuilder: (context, index) {
          return _beverageListCard(index);
        },
      );

  Widget _beverageMenuText() => Text(
        "${FoodyAppStrings.kBeverage} ${FoodyAppStrings.kMenu}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _beverageListCard(int index) => Card(
        color: Colors.white,
        child: ListTile(
          leading: _beverageListLeadingIcon(),
          title: _beverageName(index),
          subtitle: _beveragePrice(index),
          trailing: _trailingAddButton(),
        ),
      );

  Widget _beverageListLeadingIcon() => const Icon(
        Icons.local_drink_rounded,
        color: Colors.red,
      );

  Widget _beverageName(int index) => Text(
        widget.beverageList[index].itemName,
        style: const TextStyle(fontSize: 12),
      );

  Widget _beveragePrice(int index) => Text(
        "${FoodyAppStrings.kINR} ${widget.beverageList[index].itemPrice.toString()}",
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      );
}
