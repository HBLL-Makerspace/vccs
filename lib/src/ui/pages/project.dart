import 'dart:async';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:vccs/src/blocs/project_bloc/project_bloc.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class ProjectPage extends StatefulWidget {
  final String projectName;
  final String projectLocation;

  const ProjectPage(
      {Key key, @required this.projectName, @required this.projectLocation})
      : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with NavigatorObserver {
  ProjectBloc projectBloc;
  String _route;
  StreamSubscription<NotificationMessage> _messageStreamSub;

  @override
  void initState() {
    super.initState();
    projectBloc = ProjectBloc();
    projectBloc
        .add(LoadProjectEvent(widget.projectName, widget.projectLocation));
  }

  @override
  void dispose() {
    _messageStreamSub?.cancel();
    super.dispose();
  }

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

  Widget buildPage() {
    return SideNav(
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
    );
  }

  Color _getColorByType(MessageType type) {
    switch (type) {
      case MessageType.MESSAGE:
        return Theme.of(context).backgroundColor;
      case MessageType.ALERT:
        return Colors.yellow[400];
      case MessageType.ERROR:
        return Colors.red[400];
      case MessageType.SUCCESS:
        return Colors.green[400];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text(widget.projectName),
        backgroundColor: Colors.grey[800],
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: VCCSFlatButton(
              child: Text("Close Project"),
              onPressed: () {
                ExtendedNavigator.of(context).pop();
              },
              hoverColor: Colors.red[400],
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => projectBloc,
        child: BlocListener<ProjectBloc, ProjectState>(
          listener: (context, state) {
            if (state is ProjectLoadingState) {
              _messageStreamSub =
                  NotificationMessenger.onMessage().listen((event) {
                final TextStyle style = TextStyle(
                    color: _getColorByType(event.type).computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white);
                final snackBar = SnackBar(
                  // padding: EdgeInsets.zero,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event.title,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: style.color),
                      ),
                      if (event.message != null)
                        Text(
                          event.message,
                          style: style,
                        ),
                    ],
                  ),
                  duration: event.duration,
                  width: event.width,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: _getColorByType(event.type),
                  // action: SnackBarAction(
                  //   label: 'Dismiss',
                  //   onPressed: () {
                  //     // Some code to undo the change.
                  //   },
                  // ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            }
            if (state is ProjectDataState)
              NotificationMessenger.addNotification(
                  NotificationMessage("Project loaded"));
          },
          child: BlocBuilder<ProjectBloc, ProjectState>(
            bloc: projectBloc,
            builder: (context, state) {
              switch (state.runtimeType) {
                case ProjectLoadingState:
                  return Center(
                      child: Text("Loading Project... 🤪",
                          style: Theme.of(context).textTheme.headline5));
                default:
                  return buildPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
