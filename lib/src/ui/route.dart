import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:vccs/src/ui/pages/pages.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    CustomRoute(
      page: HomePage,
      initial: true,
      transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
    CustomRoute(
      page: ProjectPage,
      path: "/project",
      transitionsBuilder: TransitionsBuilders.slideLeft,
      children: <AutoRoute>[
        CustomRoute(
          page: ProjectWelcome,
          path: "/",
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 10,
        ),
        CustomRoute(
          page: CameraSetup,
          path: "/setup",
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 10,
        ),
        CustomRoute(
          page: CameraSets,
          path: "/sets",
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 10,
        ),
        CustomRoute(
          page: SetPage,
          path: "/sets/:id?",
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 10,
        ),
        CustomRoute(
          page: ModelCreation,
          path: "/model",
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 10,
        ),
        CustomRoute(
          page: Settings,
          path: "/settings",
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 10,
        ),
      ],
    ),
  ],
)
class $VCCSRoute {}
