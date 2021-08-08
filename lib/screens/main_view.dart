import 'package:citizen_feedback/screens/polls_list_view.dart';
import 'package:citizen_feedback/screens/reports_view.dart';
import 'package:citizen_feedback/widgets/main_appbar.dart';
import 'package:citizen_feedback/widgets/more_menu.dart';
import 'package:citizen_feedback/widgets/polls/list_polls.dart';
import 'package:flutter/material.dart';
import 'package:citizen_feedback/theme/theme.dart';

import 'notifications_view.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;
  PageController _pageController;

  List<Widget> tabPages = [
    PollView(),
    ReportsView(),
    NotificationsView(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          title: widget.title,
        ),
        body: PageView(
          children: tabPages,
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Turquoise,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              title: Text('Polls'),
              icon: Icon(Icons.align_horizontal_left_rounded),
            ),
            BottomNavigationBarItem(
              title: Text('Reports'),
              icon: Icon(Icons.analytics_outlined),
            ),
            BottomNavigationBarItem(
              title: Text('Notifications'),
              icon: Icon(Icons.notifications_active_outlined),
            ),
            BottomNavigationBarItem(
              title: Text('More'),
              icon: MoreMenu(context: context),
            ),
          ],
        ));
  }

  onTap(int pageIndex) {
    if (pageIndex != 3) {
      this._pageController.animateToPage(pageIndex,
          duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
    }
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
