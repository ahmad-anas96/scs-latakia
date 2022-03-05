import 'package:flutter/material.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/home/models/course_model.dart';

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
          onTap: () {},
          borderRadius: BorderRadius.circular(MAIN_RADIUS),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(MAIN_RADIUS),
                child: Image.network(
                  "$ROOT_UPLOADS/${model?.imagePath}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    return loadingProgress == null
                        ? child
                        : const SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                ),
                              ),
                            ),
                          );
                  },
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
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(MAIN_RADIUS),
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: MAIN_MARGIN / 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(
                        "${model?.tags}",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.3,
                            ),
                      ),
                    ),
                    Text(
                      "${model?.description}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
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
