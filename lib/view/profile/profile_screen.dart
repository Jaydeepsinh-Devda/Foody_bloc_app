import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/profile/profile_bloc.dart';
import 'package:foody_bloc_app/bloc/profile/profile_event.dart';
import 'package:foody_bloc_app/bloc/profile/profile_state.dart';
import 'package:foody_bloc_app/model/profile_model.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/ui_components/profile/custom_list_tile.dart';
import 'package:foody_bloc_app/ui_components/space.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileModel> _list = [];
  String _profileImagePath = "";
  late ProfileBloc _bloc;

  //! Widget Lifecycle Method
  @override
  void initState() {
    _bloc = context.read<ProfileBloc>();
    _bloc.add(GetProfileListEvent());
    _bloc.add(GetProfileImageEvent());
    super.initState();
  }

  //! Build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: _blcConsumer(),
        ),
      ),
    );
  }

  //! Widget Methods
  Widget _blcConsumer() => BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is OnProfileGetListState) {
            _list = state.list;
          }
          if (state is OnGetProfileImageState) {
            _profileImagePath = state.profileImage;
          }
        },
        builder: (context, state) => CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            _sliverToBoxAdapter(),
            _sliverList(),
          ],
        ),
      );

  Widget _sliverToBoxAdapter() => SliverToBoxAdapter(
        child: Column(
          children: [
            _userProfileImage(),
            const Space(height: 10),
            _userName(),
            _userEmail(),
            const Space(height: 30)
          ],
        ),
      );

  Widget _userProfileImage() => CircleAvatar(
        minRadius: 50,
        maxRadius: 50,
        child: ClipOval(
          child: (_profileImagePath.isEmpty)
              ? const LoadingIndicator()
              : Image.asset(
                  _profileImagePath,
                ),
        ),
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
