import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/const.dart';
import 'package:scs_latakia_app/home/view_models/courses_view_model.dart';
import 'package:scs_latakia_app/home/views/courses_list_view.dart';
import 'package:scs_latakia_app/home/views/tags_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          "الجمعية العلمية السورية للمعلوماتية - فرع اللاذقية",
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
                SliverPersistentHeader(
                  delegate: _SliverFilterBarDelegate(),
                  pinned: true,
                ),
              ];
            },
            body: const CoursesListView()),
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
    CoursesViewModel? coursesViewModel = Provider.of<CoursesViewModel?>(context);

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
                hintText: 'بحث',
                prefixIcon: const Icon(Icons.search_rounded),
              ),
            ),
          ),
          TagsListView(),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverFilterBarDelegate oldDelegate) {
    return false;
  }
}
