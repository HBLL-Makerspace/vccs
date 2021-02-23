import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with NavigatorObserver {
  String _route;

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {}

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _route = route.settings.name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SideNav(
        pages: [
          SideBarNavPage(
              icon: MaterialCommunityIcons.camera_control,
              title: "Setup",
              isSelected: _route == "/project/setup",
              onPressed: () {
                ExtendedNavigator.named("project")
                    .pushAndRemoveUntil("/setup", (route) => false);
              }),
          SideBarNavPage(
              icon: MaterialCommunityIcons.camera_outline,
              title: "Sets",
              isSelected: _route == "/project/sets",
              onPressed: () {
                ExtendedNavigator.named("project")
                    .pushAndRemoveUntil("/sets", (route) => false);
              }),
          SideBarNavPage(
              icon: MaterialCommunityIcons.cube_scan,
              title: "Model",
              isSelected: _route == "/project/model",
              onPressed: () {
                ExtendedNavigator.named("project")
                    .pushAndRemoveUntil("/model", (route) => false);
              }),
        ],
        bottom: [
          SideBarNavPage(
              icon: Ionicons.md_settings,
              title: "Settings",
              isSelected: _route == "/project/settings",
              onPressed: () {
                ExtendedNavigator.named("project")
                    .pushAndRemoveUntil("/settings", (route) => false);
              }),
        ],
        child: ExtendedNavigator(
          name: "project",
          observers: [this],
        ),
      ),
    );
  }
}
