import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/auth/models/user_model.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/course/models/user_course_details.dart';
import 'package:scs_latakia_app/course/services/course_service.dart';
import 'package:scs_latakia_app/course/view_models/course_details_provider.dart';
import 'package:scs_latakia_app/course/views/course_session_item.dart';
import 'package:scs_latakia_app/course/views/course_coach_item.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/utils/loading.dart';
import 'package:scs_latakia_app/utils/snack.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  var top = 0.0;
  String? myId = AuthProvider.loginData?.user.id;
  CourseDetailsProvider? courseDetailsProvider;

  @override
  Widget build(BuildContext context) {
    courseDetailsProvider = Provider.of<CourseDetailsProvider?>(context);
    if (courseDetailsProvider?.loading ?? true) {
      return const Loading();
    }

    return Scaffold(
      bottomNavigationBar: Builder(
        builder: (_) {
          String? status;
          var _users =
              courseDetailsProvider?.courseDetailsResponseModel?.data.users ??
                  [];

          for (var user in _users) {
            if (user.id == myId) {
              status = user.userCourse.status;
              break;
            }
          }
          if (status == null) {
            return Padding(
              padding: const EdgeInsets.all(MAIN_MARGIN / 2),
              child: ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => Loading(
                    action: () async {
                      var info = await CourseService.registerInCourse(
                        myId,
                        courseDetailsProvider?.course?.id,
                      );
                      Navigator.pop(context);

                      if (info == null) {
                        showSnackbar(context, "try again");
                        return;
                      }
                      UserModel user = AuthProvider.loginData!.user;
                      UserCourseModel userCourseModel = UserCourseModel(
                        user.id,
                        user.email,
                        user.role,
                        user.name,
                        user.bio,
                        user.linkedin,
                        user.imagePath,
                        user.mobile,
                        info.data,
                      );
                      courseDetailsProvider
                          ?.courseDetailsResponseModel?.data.users
                          .add(userCourseModel);
                      courseDetailsProvider?.notify();
                      showSnackbar(context,
                          "enrolled successfully, our team will notify you as soon possible");
                    },
                  ),
                ),
                child: const Text("Enroll"),
              ),
            );
          }
          return Container(height: 0);
        },
      ),
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder: _headerSilverBuilder,
          body: ListView(
            padding: const EdgeInsets.all(MAIN_MARGIN / 2),
            children: [
              _details,
              const SizedBox(height: 25),
              _coaches,
              const SizedBox(height: 25),
              _sessions,
            ],
          ),
        ),
      ),
    );
  }

  get _details {
    List<String> tags = courseDetailsProvider?.course?.tags.split(',') ?? [];
    String? certificate;
    var _users =
        courseDetailsProvider?.courseDetailsResponseModel?.data.users ?? [];

    for (var user in _users) {
      if (user.id == myId) {
        certificate = user.userCourse.certificate;
        break;
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: imageWithLoader(
                  courseDetailsProvider?.course?.imagePath, null),
            ),
            const VerticalDivider(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${courseDetailsProvider?.course?.title}",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontSize: 25.0),
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
                      "${NumberFormat("#,###").format(courseDetailsProvider?.course?.cost)} s.p.",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            height: 1.3,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Text(
          "Detials:",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width / 2,
          color: Theme.of(context).colorScheme.secondary,
          margin: const EdgeInsets.symmetric(vertical: MAIN_MARGIN / 4),
        ),
        Text(
          "${courseDetailsProvider?.course?.description}",
          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              tags.length,
              (index) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(MAIN_RADIUS),
                  ),
                ),
                margin: const EdgeInsets.only(
                  right: MAIN_MARGIN / 4,
                  top: MAIN_MARGIN / 2,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Text(
                  tags[index].trim(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                ),
              ),
            ),
          ),
        ),
        if (certificate != null)
          Container(
            margin: const EdgeInsets.only(top: MAIN_MARGIN),
            child: ElevatedButton.icon(
              onPressed: () {
                launch("$ROOT/uploads/$certificate");
              },
              icon: const Icon(Icons.download_rounded),
              label: const Text("Download Certificate"),
            ),
          ),
      ],
    );
  }

  get _coaches => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Coach",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width / 2,
            color: Theme.of(context).colorScheme.secondary,
            margin: const EdgeInsets.symmetric(vertical: MAIN_MARGIN / 4),
          ),
          Builder(
            builder: (context) {
              var _details =
                  Provider.of<CourseDetailsProvider?>(context, listen: false);
              var _users =
                  _details?.courseDetailsResponseModel?.data.users ?? [];

              List<Widget> items = [];
              for (var user in _users) {
                if (user.userCourse.role == "coach") {
                  items.add(CourseCoachWidget(model: user));
                  items.add(const Divider());
                }
              }

              return Column(children: items);
            },
          ),
        ],
      );

  get _sessions => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sessions",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width / 2,
            color: Theme.of(context).colorScheme.secondary,
            margin: const EdgeInsets.symmetric(vertical: MAIN_MARGIN / 4),
          ),
          Builder(
            builder: (context) {
              var _details =
                  Provider.of<CourseDetailsProvider?>(context, listen: false);
              var _sessions =
                  _details?.courseDetailsResponseModel?.data.sessions ?? [];

              List<Widget> items = [];
              for (var session in _sessions) {
                items.add(CourseSessionWidget(model: session));
                items.add(const Divider());
              }

              return Column(children: items);
            },
          ),
        ],
      );

  List<Widget> _headerSilverBuilder(context, innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: LayoutBuilder(builder: (context, constraints) {
          top = constraints.biggest.height;
          return FlexibleSpaceBar(
            centerTitle: true,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity:
                  top == MediaQuery.of(context).padding.top + kToolbarHeight
                      ? 1.0
                      : 0.0,
              child: Text(
                "${courseDetailsProvider?.course?.title}",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.white),
              ),
            ),
            background: SizedBox(
                height: 200,
                child: imageWithLoader(
                    courseDetailsProvider?.course?.coverPath, BoxFit.cover)),
          );
        }),
      ),
    ];
  }
}
