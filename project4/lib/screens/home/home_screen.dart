import 'package:flutter/material.dart';
import 'package:project4/models/comic/filter_comic.dart';
import 'package:project4/widgets/comic/list_widget/scroll_page_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  final List<Widget> _tabs = [];
  final List<Widget> _tabBarView = [];

  @override
  void initState() {
    super.initState();
    for (FilterComicType comicType in FilterComicType.values) {
      _tabs.add(Tab(text: comicType.value));
      _tabBarView.add(ScrollPageWidget(filter: comicType.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              tabAlignment: TabAlignment.start,
              tabs: _tabs,
              isScrollable: true,
            ),
            Expanded(
              child: TabBarView(
                children: _tabBarView,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
