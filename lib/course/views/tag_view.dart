import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/home/view_models/courses_view_model.dart';

class CourseDetailsButton extends StatelessWidget {
  final String tag;
  const CourseDetailsButton({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoursesViewModel? coursesViewModel =
        Provider.of<CoursesViewModel?>(context);
    bool _isSelected = coursesViewModel?.isTagSelected(tag) ?? false;

    return ChoiceChip(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(MAIN_RADIUS)),
      ),
      labelPadding: const EdgeInsets.all(5.0),
      label: Text(
        tag.trim(),
        style: Theme.of(context).textTheme.headline3!.copyWith(
              color: Colors.white,
              fontSize: 20,
              height: 1.3,
              // fontWeight: _isSelected ? FontWeight.bold : FontWeight.normal
            ),
      ),
      selected: _isSelected,
      selectedColor: Theme.of(context).colorScheme.secondaryVariant,
      backgroundColor: Colors.grey,
      onSelected: (value) => coursesViewModel?.selectedTag = value ? tag : null,
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: MAIN_MARGIN / 2),
    );
  }
}
