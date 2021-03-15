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
      page: ConfigurationPage,
      path: "/configure",
      transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
    CustomRoute(
      page: CameraPage,
      path: "/configure/cameras/:id",
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 10,
    ),
    CustomRoute(
      page: SlotPage,
      path: "/configure/slots",
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 10,
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
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 10,
        ),
        CustomRoute(
          page: CameraSets,
          path: "/sets",
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 10,
        ),
        CustomRoute(
          page: SetPage,
          path: "/sets/:id?",
          transitionsBuilder: TransitionsBuilders.slideLeft,
          durationInMilliseconds: 10,
        ),
        CustomRoute(
          page: ModelCreation,
          path: "/model",
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 10,
        ),
        CustomRoute(
          page: Settings,
          path: "/settings",
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 10,
        ),
      ],
    ),
  ],
)
class $VCCSRoute {}
