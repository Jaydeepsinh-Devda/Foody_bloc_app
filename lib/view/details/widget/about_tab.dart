import 'package:flutter/material.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/ui_components/space.dart';
import 'package:foody_bloc_app/view/details/bloc/details_bloc.dart';
import 'package:foody_bloc_app/view/details/bloc/details_state.dart';

class AboutTab extends StatefulWidget {
  final PlaceListModel element;
  final DetailsBloc bloc;
  final String aboutPlace;
  final DetailsState state;

  const AboutTab({
    required this.bloc,
    required this.state,
    required this.aboutPlace,
    required this.element,
    super.key,
  });

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab>  with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    // widget.bloc.add(AboutTabGetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.state is OnAboutTabLoadingState
        ? const LoadingIndicator()
        : CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(top: 20),
                  child: _descriptionAndAboutPlaceText()),
            )
          ]);
  }

  Widget _descriptionAndAboutPlaceText() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _descriptionText(),
          const Space(height: 10),
          _aboutPlaceText(),
        ],
      );

  Widget _descriptionText() => Text(
        FoodyAppStrings.kDescription,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _aboutPlaceText() => Text(
        widget.aboutPlace,
        textAlign: TextAlign.justify,
      );
      
        @override
        bool get wantKeepAlive => true;
}
