import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/home/view_models/courses_view_model.dart';
import 'package:scs_latakia_app/home/views/tag_view.dart';

class TagsListView extends StatelessWidget {
  const TagsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoursesViewModel? coursesViewModel =
        Provider.of<CoursesViewModel?>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: MAIN_MARGIN / 4),
        child: Row(
          children: List.generate(
            coursesViewModel?.getTags().length ?? 0,
            (index) => TagView(
              tag: coursesViewModel?.getTags()[index] ?? '',
            ),
          ),
        ),
      ),
    );
  }
}
