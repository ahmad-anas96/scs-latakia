// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/course/view_models/course_details_provider.dart';
import 'package:scs_latakia_app/course/views/course_details.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/home/models/course_model.dart';
import 'package:scs_latakia_app/utils/loading.dart';

class CourseViewList extends StatelessWidget {
  final CourseModel? model;
  const CourseViewList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(MAIN_MARGIN / 4),
      padding: const EdgeInsets.all(MAIN_MARGIN / 4),
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
            var _provider =
                Provider.of<CourseDetailsProvider?>(context, listen: false);
            _provider?.course = model;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CourseDetailsScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(MAIN_RADIUS),
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: imageWithLoader(
                  model?.imagePath,
                  null,
                ),
              ),
              const VerticalDivider(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${model?.title}",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.copyWith(height: 1.3, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(MAIN_RADIUS),
                        ),
                      ),
                      margin: const EdgeInsets.only(top: MAIN_MARGIN / 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(
                        "${model?.subTitle}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
