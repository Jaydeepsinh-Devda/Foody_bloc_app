import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/model/profile_model.dart';
import 'package:foody_bloc_app/view/profile/bloc/profile_bloc.dart';
import 'package:foody_bloc_app/view/profile/bloc/profile_event.dart';
import 'package:foody_bloc_app/view/profile/bloc/profile_state.dart';
import 'package:foody_bloc_app/model/profile_section_model.dart';
import 'package:foody_bloc_app/view/profile/widget/custom_list_tile.dart';
import 'package:foody_bloc_app/ui_components/space.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileSectionModel> _list = [];
  List<ProfileModel> _profileList = [];
  final int index = 0;
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
            _profileList = state.profileList;
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              _sliverToBoxAdapter(state),
              _sliverList(),
            ],
          );
        },
      );

  Widget _sliverToBoxAdapter(ProfileState state) => SliverToBoxAdapter(
        child: Column(
          children: [
            _userProfileImage(state),
            const Space(height: 10),
            _userName(),
            _userEmail(),
            const Space(height: 30)
          ],
        ),
      );

  Widget _userProfileImage(ProfileState state) => CircleAvatar(
        minRadius: 50,
        maxRadius: 50,
        child: ClipOval(
          child: state is OnGetProfileImageState
              ? Image.network(
                  state.profileImage,
                )
              : Text(_profileList.isEmpty
                  ? ""
                  : "${_profileList[0].firstName[0]}${_profileList[0].lastName[0]}"),
        ),
      );

  Widget _userName() => Text(
        _profileList.isEmpty ? "" : _profileList[0].firstName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _userEmail() =>
      Text(_profileList.isEmpty ? "" : _profileList[0].email);

  Widget _sliverList() => SliverList.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return CustomListTile(element: _list[index]);
        },
      );
}
