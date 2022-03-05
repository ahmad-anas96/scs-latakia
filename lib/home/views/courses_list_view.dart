import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/home/view_models/courses_view_model.dart';
import 'package:scs_latakia_app/home/views/course_view.dart';

class CoursesListView extends StatelessWidget {
  const CoursesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoursesViewModel? coursesViewModel =
        Provider.of<CoursesViewModel?>(context);

    return Container(
      padding: const EdgeInsets.all(MAIN_MARGIN / 4),
      child: coursesViewModel?.loading == true
          ? SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              ),
            )
          : (coursesViewModel?.courses.isEmpty ?? true)
              ? const SizedBox(
                  height: 200, child: Center(child: Text("No results!")))
              : StaggeredGrid.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    coursesViewModel?.courses.length ?? 0,
                    (index) => CourseView(
                      model: coursesViewModel!.courses[index],
                    ),
                  ),
                ),
    );
  }
}
