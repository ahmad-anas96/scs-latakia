import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/home/view_models/courses_view_model.dart';

class TagView extends StatelessWidget {
  final String tag;
  const TagView({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoursesViewModel? coursesViewModel =
        Provider.of<CoursesViewModel?>(context);
    bool _isSelected = coursesViewModel?.isTagSelected(tag) ?? false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MAIN_MARGIN / 4),
      child: ChoiceChip(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(MAIN_RADIUS)),
        ),
        labelPadding: const EdgeInsets.all(5.0),
        label: Text(
          tag,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
              fontSize: 15,
              height: 1.3,
              fontWeight: _isSelected ? FontWeight.bold : FontWeight.normal),
        ),
        selected: _isSelected,
        selectedColor: Theme.of(context).colorScheme.secondaryVariant,
        backgroundColor: Colors.grey,
        onSelected: (value) =>
            coursesViewModel?.selectedTag = value ? tag : null,
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: MAIN_MARGIN / 2),
      ),
    );
  }
}
