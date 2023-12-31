// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/home/views/courses_list_view.dart';
import 'package:scs_latakia_app/home/view_models/courses_view_model.dart';
import 'package:scs_latakia_app/home/views/tags_list_view.dart';
import 'package:scs_latakia_app/more/views/more.dart';
import 'package:scs_latakia_app/my_courses/view_models/my_courses_view_model.dart';
import 'package:scs_latakia_app/my_courses/views/my_courses_list_view.dart';
import 'package:scs_latakia_app/profile/views/profile.dart';
import 'package:scs_latakia_app/updates/view_models/update_view_model.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  var top = 0.0;
  bool _update = false;
  final _pages = const <Widget>[
    CoursesListView(),
    ProfilePageWidget(),
    MyCoursesListView(),
    MorePageWidget(),
  ];

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    UpdateViewModel? updateViewModel = Provider.of<UpdateViewModel?>(context);
    int currentVersionCode = int.parse(await getVersionCode());
    int versionCode =
        int.parse(updateViewModel?.updateModel?.versionCode ?? '0');

    if (versionCode > currentVersionCode && !_update) {
      showDialog(
        context: context,
        builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("${AppLocalizations.of(context)?.update}"),
            content: Text("${AppLocalizations.of(context)?.updateText}"),
            actions: [
              TextButton(
                onPressed: () =>
                    launch("${updateViewModel?.updateModel?.play}"),
                child: Text("${AppLocalizations.of(context)?.update}"),
              ),
              TextButton(
                  onPressed: () =>
                      launch("${updateViewModel?.updateModel?.direct}"),
                  child:
                      Text("${AppLocalizations.of(context)?.directDownload}"))
            ],
          ),
        ),
      );
      setState(() {
        _update = true;
      });
    }
  }

  String? get title {
    switch (_currentIndex) {
      case 0:
        return "${AppLocalizations.of(context)?.titleLabel}";
      case 1:
        return "${AppLocalizations.of(context)?.profile}";
      case 2:
        return "${AppLocalizations.of(context)?.myCourses}";
      case 3:
        return "${AppLocalizations.of(context)?.more}";
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    CoursesViewModel? coursesViewModel =
        Provider.of<CoursesViewModel?>(context);

    MyCoursesViewModel? myCoursesViewModel =
        Provider.of<MyCoursesViewModel?>(context);

    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          return true;
        }
        setState(() {
          _currentIndex = 0;
        });
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          onTap: (value) => setState(() {
            _currentIndex = value;
          }),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: "${AppLocalizations.of(context)?.home}"),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: "${AppLocalizations.of(context)?.profile}"),
            BottomNavigationBarItem(
                icon: const Icon(Icons.school_rounded),
                label: "${AppLocalizations.of(context)?.myCourses}"),
            BottomNavigationBarItem(
                icon: const Icon(Icons.more_vert),
                label: "${AppLocalizations.of(context)?.more}"),
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  expandedHeight: 150.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                    top = constraints.biggest.height;
                    return FlexibleSpaceBar(
                      centerTitle: true,
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: top ==
                                MediaQuery.of(context).padding.top +
                                    kToolbarHeight
                            ? 1.0
                            : 0.0,
                        child: Text(
                          title ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      background: Image.asset(
                        "assets/images/scs-header.jpg",
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                ),
                if (_currentIndex == 0)
                  SliverPersistentHeader(
                    delegate: _SliverFilterBarDelegate(),
                    pinned: true,
                  ),
              ];
            },
            body: RefreshIndicator(
              color: Theme.of(context).colorScheme.primary,
              onRefresh: () async {
                await coursesViewModel?.reload();
                await myCoursesViewModel?.reload();
              },
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: _pages[_currentIndex],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverFilterBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 120;
  @override
  double get maxExtent => 120;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    CoursesViewModel? coursesViewModel =
        Provider.of<CoursesViewModel?>(context);

    if (coursesViewModel?.loading == true) {
      return Container();
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: MAIN_MARGIN / 2,
              right: MAIN_MARGIN / 2,
              top: MAIN_MARGIN / 2,
              bottom: MAIN_MARGIN / 4,
            ),
            child: TextFormField(
              onChanged: (value) => coursesViewModel?.search = value,
              textInputAction: TextInputAction.search,
              decoration: INPUT_DECORATION.copyWith(
                hintText: "${AppLocalizations.of(context)?.search}",
                prefixIcon: const Icon(Icons.search_rounded),
              ),
            ),
          ),
          const TagsListView(),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverFilterBarDelegate oldDelegate) {
    return true;
  }
}
