import 'package:flutter/material.dart';
import 'package:foody_bloc_app/model/profile_section_model.dart';

class CustomListTile extends StatelessWidget {
  final ProfileSectionModel element;
  const CustomListTile({
    required this.element,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _leadingIcon(),
      title: _title(),
      subtitle: _subTitle(),
      trailing: _trailingIcon(),
    );
  }

  Widget _leadingIcon() => CircleAvatar(
      backgroundColor: Colors.red.withOpacity(0.2),
      child: Icon(
        element.icon,
        color: Colors.red,
      ));

  Widget _title() => Text(element.title);

  Widget _subTitle() => Text(element.subTitle);

  Widget _trailingIcon() => const Icon(Icons.chevron_right_sharp);
}
