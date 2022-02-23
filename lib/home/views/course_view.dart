import 'package:flutter/material.dart';
import 'package:scs_latakia_app/const.dart';
import 'package:scs_latakia_app/home/models/course_model.dart';

class CourseView extends StatelessWidget {
  final CourseModel? model;
  const CourseView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(MAIN_MARGIN / 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MAIN_RADIUS),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5.0,
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO
          },
          borderRadius: BorderRadius.circular(MAIN_RADIUS),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(MAIN_RADIUS),
                child: Image.asset("assets/images/scs-logo.jpg"),
              ),
              Container(
                padding: const EdgeInsets.all(MAIN_MARGIN / 4),
                child: Text(
                  "${model?.title}",
                  style: Theme.of(context).textTheme.headline3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
