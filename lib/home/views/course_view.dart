// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/course/view_models/course_details_provider.dart';
import 'package:scs_latakia_app/course/views/course_details.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/home/models/course_model.dart';
import 'package:scs_latakia_app/utils/loading.dart';

class CourseView extends StatelessWidget {
  final CourseModel model;
  const CourseView({Key? key, required this.model}) : super(key: key);

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
          child: Column(
            children: [
              SizedBox(
                height: 110,
                child: imageWithLoader(model.imagePath, null),
              ),
              Container(
                width: double.infinity,
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
                  "${model.subTitle}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                ),
              ),
              const Divider(),
              Text(
                model.title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(height: 1.3, fontWeight: FontWeight.w600),
              ),
              Text(
                model.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Column(
                children: List.generate(
                  model.tags.split(',').length,
                  (index) => Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(MAIN_RADIUS),
                      ),
                    ),
                    margin: const EdgeInsets.only(top: MAIN_MARGIN / 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Text(
                      model.tags.split(',')[index].trim(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
