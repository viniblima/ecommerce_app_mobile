import 'dart:convert';

import 'package:church_app/controllers/config.controller.dart';
import 'package:church_app/widgets/app_bar_tabs.widget.dart';
import 'package:church_app/widgets/button_tabs.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../widgets/custom_tab_view.widget.dart';

class InitialTabsPage extends StatefulWidget {
  const InitialTabsPage({Key? key}) : super(key: key);

  @override
  State<InitialTabsPage> createState() => _InitialTabsPageState();
}

class _InitialTabsPageState extends State<InitialTabsPage>
    with TickerProviderStateMixin {
  int initPosition = 0;

  List<Map<String, dynamic>> pages = [];

  bool showPage = false;

  late TabController controller;
  late int _currentPosition;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    initTabs();
    super.initState();
  }

  void initTabs() async {
    String jsonString =
        await rootBundle.loadString('main_config/application.json');
    Map<String, dynamic> config = json.decode(jsonString);
    List tabs = config['tabs'];
    for (Map<String, dynamic> element in tabs) {
      pages.add(
        {
          'page': Config.pages[element['name']]!,
          'button_tab': element['button_tab'],
        },
      );
    }
    _currentPosition = initPosition;
    controller = TabController(
      length: pages.length,
      vsync: this,
      initialIndex: _currentPosition,
    );
    setState(() {
      showPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBarTabs(
          title: 'titulo',
          onPressLeading: () => scaffoldKey.currentState!.openDrawer(),
        ),
        // drawer: const SideMenu(),
        bottomNavigationBar: showPage
            ? TabBar(
                controller: controller,
                labelColor: Theme.of(context).primaryColorLight,
                unselectedLabelColor: Config.colors[ColorVariables.primary],
                indicator: BoxDecoration(
                  color: Config.colors[ColorVariables.primary],
                ),
                tabs: List.generate(
                  pages.length,
                  (int index) => ButtonTabs(
                    name: pages[index]['button_tab']['name'],
                    icon: Config.icons[pages[index]['button_tab']['icon']]!,
                  ),
                ),
                isScrollable: false,
              )
            : Container(),
        body: showPage
            ? CustomTabView(
                controller: controller,
                initPosition: initPosition,
                itemCount: pages.length,
                pageBuilder: (context, index) => pages[index]['page'],
                onPositionChange: (index) {
                  initPosition = index;
                },
                onScroll: (position) {},
              )
            : Container(),
      ),
    );
  }
}
