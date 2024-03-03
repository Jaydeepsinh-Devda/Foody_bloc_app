import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/profile/profile_bloc.dart';
import 'package:foody_bloc_app/bloc/profile/profile_event.dart';
import 'package:foody_bloc_app/bloc/profile/profile_state.dart';
import 'package:foody_bloc_app/model/profile_model.dart';
import 'package:foody_bloc_app/ui_components/profile/custom_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileModel> _list = [];
  late ProfileBloc _bloc;
  @override
  void initState() {
    _bloc = context.read<ProfileBloc>();
    _bloc.add(GetListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is OnGetListState) {
                _list = state.list;
              }
            },
            builder: (context, state) => CustomScrollView(
              slivers: [
                _sliverToBoxAdapter(),
                _sliverList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sliverToBoxAdapter() => SliverToBoxAdapter(
        child: Column(
          children: [
            _userProfileImage(),
            _userName(),
            _userEmail(),
          ],
        ),
      );

  Widget _userProfileImage() => const CircleAvatar(
        backgroundColor: Colors.red,
        minRadius: 50,
      );

  Widget _userName() => const Text(
        "Name",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _userEmail() => const Text("Email");

  Widget _sliverList() => SliverList.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return CustomListTile(element: _list[index]);
        },
      );
}
